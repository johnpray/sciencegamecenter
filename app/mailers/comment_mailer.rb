class CommentMailer < ActionMailer::Base
  default from: "SGC Admins <#{ENV['ADMINS_EMAIL']}>",
          reply_to: ENV['ADMINS_EMAIL']

  def notify_for_approval(comment)
    @comment = comment
    admin = "SGC Admins <#{ENV['ADMINS_EMAIL']}>"
    mail(
      to: admin,
      subject: "A comment is awaiting approval"
    )
  end
end
