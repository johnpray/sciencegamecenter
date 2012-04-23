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
  	filename = Rails.env.production? ? "config/robots.production.txt" : "config/robots.development.txt"
  	robots = File.read(Rails.root + filename)
  	render text: robots, layout: false, content_type: 'text/plain'
  end
end
