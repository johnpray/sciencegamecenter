class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :status

  default_scope { order(created_at: :asc) }

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_paper_trail

  validates :content, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

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
end
