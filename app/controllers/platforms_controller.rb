class PlatformsController < ApplicationController
  def index
  	@taggings = ActsAsTaggableOn::Tagging.where(context: 'platforms').group(:tag_id)
  end
end
