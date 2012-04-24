class SubjectsController < ApplicationController
  def index
  	if Rails.env.development?
			@taggings = ActsAsTaggableOn::Tagging.where(context: 'subjects').group(:tag_id)
  	else
  		@taggings = ActsAsTaggableOn::Tagging.where(context: 'subjects')
				.select('DISTINCT ON (tag_id) *')
  	end
  end
end
