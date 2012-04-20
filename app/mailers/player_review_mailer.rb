class PlayerReviewMailer < ActionMailer::Base
  default from: "ScienceGameCenter.org@fas.org",
          reply_to: 'sciencegamecenter@fas.org'

  

  def notify_for_approval(player_review)
    @player_review = player_review
    admin = "ScienceGameReviews Admins <sciencegamecenter@fas.org>"
    mail(
      to: admin,
      subject: "A new player review is awaiting approval"
    )
  end

end
