class PlayerReviewMailer < ActionMailer::Base
  default from: "SGC Admins <#{ENV['ADMINS_EMAIL']}>",
          reply_to: ENV['ADMINS_EMAIL']

  def notify_for_approval(player_review)
    @player_review = player_review
    admin = "SGC Admins <#{ENV['ADMINS_EMAIL']}>"
    mail(
      to: admin,
      subject: "A player review is awaiting approval"
    )
  end

end
