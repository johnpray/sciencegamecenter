class SubjectsController < ApplicationController
  def index
  	@tags = Game.tag_counts_on('subjects').order('name ASC')
  end
end
