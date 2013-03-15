# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  is_admin   :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :is_admin, :password, :birth_date,
									:disabled, :parent_email, :is_teacher, :is_scientist,
									:is_authoritative, :is_game_developer, :description
	before_save :create_remember_token

	default_scope order: 'name ASC'

	has_many :player_reviews, dependent: :nullify
	has_many :comments, dependent: :nullify

	has_paper_trail

	alias_attribute :admin, :is_admin
	alias_attribute :teacher, :is_teacher
	alias_attribute :scientist, :is_scientist
	alias_attribute :authoritative, :is_authoritative
	alias_attribute :game_developer, :is_game_developer
	alias_attribute :developer, :is_game_developer
	alias_attribute :is_developer, :is_game_developer

	validates :name,	presence: true,
										length: { maximum: 50 },
										exclusion: { in: %w(admin superuser administrator fasadmin) },
										uniqueness: { case_sensitive: false }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password,	length: { minimum: 6 }

	validates :birth_date, presence: true
	validates :parent_email, format: { with: VALID_EMAIL_REGEX },
													 if: :is_under_thirteen?
	validate :parent_email_differs_from_email, if: :is_under_thirteen?

	def is_under_thirteen?
		13.years.ago < self.birth_date
	end

	def is_expert?
		is_teacher? || is_scientist? || is_game_developer?
	end

	def roles
		return description if description && !description.empty?
		roles = []
		if is_admin
			roles += ["SGC Admin"]
		end
		if is_authoritative
			roles += ["Authoritative"]
		end
		if is_teacher
			roles += ["Teacher"]
		end
		if is_scientist
			roles += ["Scientist"]
		end
		if is_game_developer
			roles += ["Game Developer"]
		end
		roles = roles.count > 0 ? roles.join(", ") : "Player"
	end

	def send_password_reset
  	generate_token(:password_reset_token)
  	self.password_reset_sent_at = Time.zone.now
  	save!(validate: false)
  	UserMailer.password_reset(self).deliver
  end

  def self.from_omniauth(auth)
  	existing_password_user = where(email: auth.info.email).first
  	if existing_password_user && (existing_password_user.uid.blank? || existing_password_user.provider != auth.provider)
  		existing_password_user.provider = auth.provider
  		existing_password_user.uid = auth.uid
  		existing_password_user.oauth_token = auth.credentials.token
		  existing_password_user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		  existing_password_user.save!(validate: false)
		  existing_password_user
  	else
	  	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
		  	user.provider = auth.provider
		    user.uid = auth.uid
		    user.oauth_token = auth.credentials.token
		    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		    user.name ||= auth.info.name
		    user.email ||= auth.info.email
		    user.birth_date ||= DateTime.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y')
		  	user.save!(validate: false)
		  end
		end
  end

	private

		def create_remember_token
			generate_token(:remember_token)
		end

		def generate_token(column)
		  begin
		    self[column] = SecureRandom.urlsafe_base64
		  end while User.exists?(column => self[column])
		end

		def parent_email_differs_from_email
    if email == parent_email
      errors.add(:parent_email, "must be different from your own.") 
	    end
	  end
end
