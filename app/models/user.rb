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
	before_save :get_parental_confirmation

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

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end

		# If a user is under thirteen, email their parent for account activation
		def get_parental_confirmation
			if is_under_thirteen?
				self.disabled = true
				# send email to parent_email
			end
		end

		def parent_email_differs_from_email
    if email == parent_email
      errors.add(:parent_email, " must be different from your own.") 
    end
  end
end
