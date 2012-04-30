class StaticPagesController < ApplicationController
  def home
    @games = Game.all
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def robots
  	if Rails.env.production? && request.host.include?("sciencegamecenter.org")
	  	filename = "config/robots.production.txt"
	  else
  		filename = "config/robots.development.txt"
  	end
  	robots = File.read(Rails.root + filename)
  	render text: robots, layout: false, content_type: 'text/plain'
  end
end
