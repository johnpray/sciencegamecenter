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
									:disabled, :parent_email
	before_save :create_remember_token

	validates :name,	presence: true,
										length: { maximum: 50 },
										uniqueness: true

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

	def enable
		self.disabled = false
		self.save(validate: false)
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
