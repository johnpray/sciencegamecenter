class PlatformsController < ApplicationController
  def index
  	@taggings = ActsAsTaggableOn::Tagging.where(context: 'platforms')
  end
end
