class SubjectsController < ApplicationController
  def index
  	if Rails.env.production?
			@taggings = ActsAsTaggableOn::Tagging.where(context: 'subjects')
				.select('DISTINCT ON (tag_id) *')
  	else
  		@taggings = ActsAsTaggableOn::Tagging.where(context: 'subjects').group(:tag_id)
  	end
  end
end
