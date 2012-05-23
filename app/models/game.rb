class Game < ActiveRecord::Base
  attr_accessible :title, :description, :website_url, :developer,
  								:intended_audience, :concepts,
  								:boxart, :platform_list, :subject_list

  default_scope order: 'title ASC'

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :player_reviews, dependent: :destroy
  has_many :screenshots,		dependent: :destroy
  has_many :youtube_videos,	dependent: :destroy

  has_paper_trail

  acts_as_taggable_on :subjects, :platforms

  has_attached_file :boxart,
  									styles: {
  										large: '500x500>',
  										medium: '300x300>',
  										small: '100x100>',
  										thumb: '100x100#',
  										banner: '2000x90#'
  									},
  									convert_options: { banner: "-blur 0x8" },
  									storage: :s3,
  									s3_credentials: S3_CREDENTIALS,
  									s3_protocol: :http,
  									default_url: 'no_box.png'

  validates :title,	presence: true
  validates_attachment :boxart, content_type: {
  										 content_type: ['image/jpeg', 'image/png', 'image/gif'] }

  def actual_player_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if !r.user.is_expert? && !r.user.is_authoritative?
  	end
  	reviews
  end

  def authoritative_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user.is_authoritative?
  	end
  	reviews
  end

  def expert_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user.is_expert?
  	end
  	reviews
  end

	def player_fun_average(round = true)
		if self.approved_player_reviews_count < 1
			-1
		elsif @player_fun_rating_average
			round ? @player_fun_rating_average.round(1) : @player_fun_rating_average
		else
			total = 0
			count = 0
			self.player_reviews.each do |r|
				total += r.fun_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@player_fun_rating_average = total / count
			round ? @player_fun_rating_average.round(1) : @player_fun_rating_average
		end
	end

	def player_accuracy_average(round = true)
		if self.approved_player_reviews_count < 1
			-1
		elsif @player_accuracy_rating_average
			round ? @player_accuracy_rating_average.round(1) : @player_accuracy_rating_average
		else
			total = 0
			count = 0
			self.player_reviews.each do |r|
				total += r.accuracy_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@player_accuracy_rating_average = total / count
			round ? @player_accuracy_rating_average.round(1) : @player_accuracy_rating_average
		end
	end

	def player_effectiveness_average(round = true)
		if self.approved_player_reviews_count < 1
			-1
		elsif @player_effectiveness_rating_average
			round ? @player_effectiveness_rating_average.round(1) : @player_effectiveness_rating_average
		else
			total = 0
			count = 0
			self.player_reviews.each do |r|
				total += r.effectiveness_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@player_effectiveness_rating_average = total / count
			round ? @player_effectiveness_rating_average.round(1) : @player_effectiveness_rating_average
		end
	end

	def player_averages_total
		if self.approved_player_reviews_count < 1
			-1
		elsif @player_rating_averages_total
			@player_rating_averages_total.round(1)
		else
			@player_rating_averages_total =
				player_fun_average(false) +
				player_accuracy_average(false) +
				player_effectiveness_average(false)
			@player_rating_averages_total.round(1)
		end
	end

	def approved_player_reviews_count
		count = 0
		unless self.player_reviews.nil?
			self.player_reviews.each do |r|
				count += 1 if r.approved?
			end
		end
		count
	end
end
