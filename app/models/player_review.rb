class PlayerReview < ActiveRecord::Base
  attr_accessible :accuracy_rating, :content, :effectiveness_rating,
  								:fun_rating, :game_id, :status, :title, :user_id

  belongs_to :game
  belongs_to :user

  validates :title,		presence: true
  validates :content, presence: true

  validates :user_id, presence: true
  validates :game_id, presence: true

  default_scope order: 'player_reviews.created_at DESC'
end
