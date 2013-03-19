class PlayerReview < ActiveRecord::Base
  attr_accessible :accuracy_rating, :content, :effectiveness_rating,
  								:fun_rating, :game_id, :title, :status

  default_scope order: 'created_at DESC'

  belongs_to :game
  belongs_to :user
  has_many :comments, as: :commentable

  has_paper_trail

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

  def self.chart_data(start = 3.weeks.ago)
    total_count = unscoped.count_by_day(start)
#    expert_count = unscoped.count_by_day(start)
#    authoritative_count = 
    max_total_count = 0
    (start.to_date..Date.today).map do |date|
      {
        created_at: date,
        count: max_total_count += (total_count[date] || 0).to_int,
      } 
    end
  end

  def self.count_by_day(start)
    reviews = where(created_at: start.beginning_of_day..Time.zone.now)
    reviews = reviews.group('date(created_at)')
    reviews = reviews.order('date(created_at)')
    reviews = reviews.select('date(created_at) as created_at, count(*) as count')
    total_count = 0
    reviews.each_with_object({}) do |review, counts|
      total_count += review.count
      counts[review.created_at.to_date] = total_count
    end
  end
end
