class Screenshot < ActiveRecord::Base
  attr_accessible :game_id, :image, :description

  default_scope { order(created_at: :asc) }

  belongs_to :game

  has_paper_trail

  has_attached_file :image,
									styles: {
										large: '1000x1000>',
										medium: '800x800>',
										small: '500x500>',
										thumb: '300x300#',
										banner: '2000x90#',
										carousel: '780x400#'
									},
									convert_options: { banner: "-blur 0x8" },
									storage: :s3,
									s3_credentials: S3_CREDENTIALS,
									s3_protocol: :https,
									default_url: 'no_box.png'

  validates_attachment :image, content_type: {
  										 content_type: ['image/jpeg', 'image/png', 'image/gif'] },
  										 presence: true

  def next
  	game.screenshots.where('id > ?', id).first
  end

  def previous
		game.screenshots.where('id < ?', id).last
  end

end
