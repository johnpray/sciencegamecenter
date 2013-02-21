class GameMailer < ActionMailer::Base
  default from: "ScienceGameCenter.org@fas.org",
          reply_to: 'sciencegamecenter@fas.org'

  

  def notify_of_new_game(game)
    @game = game
    admin = "SGC Admins <sciencegamecenter@fas.org>"
    mail(
      to: admin,
      subject: "A game has been suggested"
    )
  end

end
