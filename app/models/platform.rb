class Platform < ActiveRecord::Base
  attr_accessible :name, :short_name

  validates :name,	presence: true,
										length: { maximum: 50 },
										uniqueness: true
  validates :short_name,	presence: true,
													length: { maximum: 10 },
													uniqueness: true
end
