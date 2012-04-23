class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
end
