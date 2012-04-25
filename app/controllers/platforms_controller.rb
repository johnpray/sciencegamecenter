class PlatformsController < ApplicationController
  def index
  	#if Rails.env.development?
  		#@taggings = ActsAsTaggableOn::Tagging.where(context: 'platforms').group(:tag_id)
  		@taggings = Game.tag_counts_on('platforms').order('name ASC')
  	#else
  	#	@taggings = ActsAsTaggableOn::Tagging.where(context: 'platforms')
		#		.select('DISTINCT ON (tag_id) *')
  	#end
  end
end
