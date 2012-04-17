class PlayerReviewMailer < ActionMailer::Base
  default from: "ScienceGameReviews.org@fas.org",
          reply_to: 'sciencegamereviews@fas.org'

  def notify_for_approval(player_review)
    @player_review = player_review
    admin = "ScienceGameReviews Admins <administrator@fas.org>"
    mail(
      to: admin,
      subject: "A new player review is awaiting approval"
    )
  end

end
