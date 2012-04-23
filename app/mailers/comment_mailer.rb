class CommentMailer < ActionMailer::Base
  default from: "ScienceGameCenter.org@fas.org",
          reply_to: 'sciencegamecenter@fas.org'

  def notify_for_approval(comment)
    @comment = comment
    admin = "SGC Admins <sciencegamecenter@fas.org>"
    mail(
      to: admin,
      subject: "A comment is awaiting approval"
    )
  end
end
