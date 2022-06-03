class GameMailer < ActionMailer::Base
  default from: "SGC Admins <#{ENV['ADMINS_EMAIL']}>",
          reply_to: ENV['ADMINS_EMAIL']

  def notify_of_new_game(game, submitting_user)
    @game = game
    @submitting_user = submitting_user
    admin = "SGC Admins <#{ENV['ADMINS_EMAIL']}>"
    mail(
      to: admin,
      subject: "A game has been suggested"
    )
  end

end
