class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def robots
  	if request.host.include?("sciencegamecenter.org") && !request.host.include?("heroku") && !request.host.include?("test.sciencegamecenter.org")
	  	filename = "config/robots.production.txt"
	  else
  		filename = "config/robots.development.txt"
  	end
  	robots = File.read(Rails.root + filename)
  	render text: robots, layout: false, content_type: 'text/plain'
  end
end
