class PlayerReview < ActiveRecord::Base
  attr_accessible :accuracy_rating, :content, :effectiveness_rating,
  								:fun_rating, :game_id, :title

  belongs_to :game
  belongs_to :user

  validates :title,		presence: true
  validates :content, presence: true

  validates :fun_rating,
	  numericality: {
	  	only_integer: true,
	  	greater_than_or_equal_to: 0,
	  	less_than_or_equal_to: 5
	  }
	  validates :accuracy_rating,
	  numericality: {
	  	only_integer: true,
	  	greater_than_or_equal_to: 0,
	  	less_than_or_equal_to: 5
	  }
	  validates :effectiveness_rating,
	  numericality: {
	  	only_integer: true,
	  	greater_than_or_equal_to: 0,
	  	less_than_or_equal_to: 5
	  }

  validates :user_id, presence: true
  validates :game_id, presence: true

  default_scope order: 'player_reviews.created_at DESC'

  def approved?
  	self.status == 'Approved'
  end

  def approve!
  	self.update_attribute(:status, 'Approved')
  end

  def pending?
  	self.status == 'Pending' || self.status.nil?
  end

  def make_pending!
  	self.update_attribute(:status, 'Pending')
  end

  def ratings_total
    self.fun_rating + self.accuracy_rating + self.effectiveness_rating
  end

  def ratings_total_percentage
    ((self.ratings_total.to_f / 15) * 100).to_i
  end
end
