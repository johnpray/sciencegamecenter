class PlatformsController < ApplicationController
  def index
  	@tags = Game.tag_counts_on('platforms').order('name ASC')
  end
end
