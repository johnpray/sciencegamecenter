class YoutubeVideo < ActiveRecord::Base
  attr_accessible :description, :game_id, :youtube_vi

  belongs_to :game

  validates :youtube_vi, presence: true
end
