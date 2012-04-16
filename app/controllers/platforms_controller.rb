class PlatformsController < ApplicationController
  def index
  	if Rails.env.production?
			@taggings = ActsAsTaggableOn::Tagging.where(context: 'platforms')
				.select('DISTINCT ON tag_id *')
  	else
  		@taggings = ActsAsTaggableOn::Tagging.where(context: 'platforms').group(:tag_id)
  	end
  end
end
