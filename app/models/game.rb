class Game < ActiveRecord::Base
  attr_accessible :title, :description, :website_url

  validates :title,	presence: true
end
