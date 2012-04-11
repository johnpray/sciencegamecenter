class UserMailer < ActionMailer::Base
  default from: "sciencegamereviews@fas.org"

  def parent_confirmation(user)
  	@user = user
  	mail(to: user.parent_email, subject: "Please confirm your child's account on ScienceGameReviews.org")
  end
end
