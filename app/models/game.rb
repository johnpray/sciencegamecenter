class Game < ActiveRecord::Base
  attr_accessible :title, :description, :website_url, :boxart,
  								:boxart_file_name, :boxart_file_size,
  								:boxart_content_type, :boxart_updated_at

  has_attached_file :boxart,
  									styles: { large: '500x500>', medium: '300x300>', small: '100x100>'},
  									storage: :s3,
  									s3_credentials: S3_CREDENTIALS,
  									default_url: 'no_box.png'
  									
  validates :title,	presence: true
  validates_attachment :boxart, content_type: {
  										 content_type: ['image/jpeg', 'image/png', 'image/gif'] }
end
