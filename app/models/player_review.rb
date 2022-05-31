class PlayerReview < ActiveRecord::Base
  attr_accessible :accuracy_rating, :content, :effectiveness_rating,
  								:fun_rating, :game_id, :title, :status

  default_scope { order(created_at: :desc) }

  scope :approved, -> { where(status: "Approved") }

  belongs_to :game
  belongs_to :user
  has_many :comments, as: :commentable

  has_paper_trail

  after_save :touch_game_if_approved
  after_save :update_game_approved_reviews_count

  validates :title,		presence: true
  validates :content, presence: true

  validates :fun_rating,
	  numericality: {
	  	greater_than_or_equal_to: 0,
	  	less_than_or_equal_to: 5
	  }
	  validates :accuracy_rating,
	  numericality: {
	  	greater_than_or_equal_to: 0,
	  	less_than_or_equal_to: 5
	  }
	  validates :effectiveness_rating,
	  numericality: {
	  	greater_than_or_equal_to: 0,
	  	less_than_or_equal_to: 5
	  }

  validates :user_id, presence: true
  validates :game_id, presence: true

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

  def touch_game_if_approved
    # so that the game will jump to the top of any "most recently updated" lists
    if status == 'Approved'
      game.touch
    end
  end

  def update_game_approved_reviews_count
    unless game.approved_reviews_count == game.player_reviews.approved.count
      game.update_column(:approved_reviews_count, game.player_reviews.approved.count)
    end
  end

  def ratings_total
    self.fun_rating + self.accuracy_rating + self.effectiveness_rating
  end

  def ratings_total_percentage
    ((self.ratings_total.to_f / 15) * 100).to_i
  end

  def self.chart_data(start = 3.weeks.ago) #TODO: Make this not run a query for each date
    (start.to_date..Date.today).map do |date|
      if (date == start.to_date) || (date == Date.today) || (PlayerReview.where(status: "Approved").where(["date(created_at) = ?", date]).count > 0)
      {
        created_at: date,
        count: PlayerReview.where(status: "Approved").where(["date(created_at) <= ?", date]).count
      }
      else
      {
        created_at: date
      }
      end
    end
  end
end
