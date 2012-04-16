class SubjectsController < ApplicationController
  def index
  	@taggings = ActsAsTaggableOn::Tagging.where(context: 'subjects')
  end
end
