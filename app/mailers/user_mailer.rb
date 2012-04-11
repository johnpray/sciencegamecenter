class UserMailer < ActionMailer::Base
  default from: "sciencegamereviews@fas.org"

  def parent_confirmation(user)
  	@user = user
  	mail(to: user.parent_email, subject: "Please confirm your child's account on ScienceGameReviews.org")
  end

  def inform_of_activation(user)
  	@user = user
  	mail(to: "#{user.name} <#{user.email}>", cc: user.parent_email, subject: "Your ScienceGameReviews.org account has been activated!")
  end
end
