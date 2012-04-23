class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id

  belongs_to :commentable, polymorphic: true
  belongs_to :user

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
