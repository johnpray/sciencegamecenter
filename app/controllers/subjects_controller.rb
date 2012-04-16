class SubjectsController < ApplicationController
  def index
  	@taggings = ActsAsTaggableOn::Tagging.where(context: 'subjects').group(:tag_id)
  end
end
