class YoutubeVideo < ActiveRecord::Base
  attr_accessible :description, :game_id, :youtube_vi

  default_scope order: 'created_at ASC'

  belongs_to :game

  has_paper_trail

  validates :youtube_vi, presence: true
end
