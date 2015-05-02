class StaticPagesController < ApplicationController
  def home
    @games = Game.enabled.order('updated_at DESC')
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def review
  end

  def forum_approval
    unless current_user && current_user.needs_forum_approval?
      redirect_to root_path
    end
  end

  def robots
  	if Rails.env.production? && request.host.include?("www.sciencegamecenter.org")
	  	filename = "config/robots.production.txt"
	  else
  		filename = "config/robots.development.txt"
  	end
  	robots = File.read(Rails.root + filename)
  	render text: robots, layout: false, content_type: 'text/plain'
  end
end
