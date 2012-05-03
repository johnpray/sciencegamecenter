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
      bcc: 'administrator@fas.org',
      subject: "Please confirm your child's account at the Science Game Center"
    )
  end

  def inform_of_activation(user)
  	@user = user
  	mail(
      to: "#{user.name} <#{user.email}>", 
      cc: user.parent_email,
      bcc: 'administrator@fas.org',
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

  def inform_of_email_change(user, old_email)
    @user = user
    @old_email = old_email
    mail(
      to: "#{user.name} <#{old_email}>",
      cc: "#{user.name} <#{user.email}>",
      subject: "Your email address at the Science Game Center has been changed"
    )
  end

  def inform_of_password_change(user)
    @user = user
    mail(
      to:  "#{user.name} <#{user.email}>", 
      subject: "Your password at the Science Game Center has been changed"
    )
  end
end
