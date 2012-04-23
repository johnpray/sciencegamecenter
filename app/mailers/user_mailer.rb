class UserMailer < ActionMailer::Base
  default from: "ScienceGameCenter.org@fas.org",
          reply_to: 'sciencegamecenter@fas.org'

  def inform_of_signup(user)
    @user = user
    mail(
      to: "#{user.name} <#{user.email}>",
      bcc: 'sciencegamecenter@fas.org',
      subject: "Your Science Game Center account has been created!"
    )
  end

  def parent_confirmation(user)
  	@user = user
  	mail(
      to: user.parent_email,
      subject: "Please confirm your child's account at the Science Game Center"
    )
  end

  def inform_of_activation(user)
  	@user = user
  	mail(
      to: "#{user.name} <#{user.email}>", 
      cc: user.parent_email,
      bcc: 'sciencegamecenter@fas.org',
      subject: "Your Science Game Center account has been activated!"
    )
  end

  def password_reset(user)
  	@user = user
  	mail(
      to:  "#{user.name} <#{user.email}>", 
      subject: "Password reset instructions for your Science Game Center account"
    )
  end
end
