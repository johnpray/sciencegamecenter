class Game < ActiveRecord::Base
  attr_accessible :title, :description, :website_url, :boxart,
  								:boxart_file_name, :boxart_file_size,
  								:boxart_content_type, :boxart_updated_at

  has_many :player_reviews, dependent: :destroy

  has_attached_file :boxart,
  									styles: { large: '500x500>', medium: '300x300>', small: '100x100>'},
  									storage: :s3,
  									s3_credentials: S3_CREDENTIALS,
  									default_url: 'no_box.png'
  									
  validates :title,	presence: true
  validates_attachment :boxart, content_type: {
  										 content_type: ['image/jpeg', 'image/png', 'image/gif'] }

	def player_fun_average(round = true)
		if @player_fun_rating_average
			round ? @player_fun_rating_average.round(1) : @player_fun_rating_average
		else
			total = 0
			self.player_reviews.each do |r|
				total += r.fun_rating.to_f
			end
			@player_fun_rating_average = total / self.player_reviews.count
			round ? @player_fun_rating_average.round(1) : @player_fun_rating_average
		end
	end

	def player_accuracy_average(round = true)
		if @player_accuracy_rating_average
			round ? @player_accuracy_rating_average.round(1) : @player_accuracy_rating_average
		else
			total = 0
			self.player_reviews.each do |r|
				total += r.accuracy_rating.to_f
			end
			@player_accuracy_rating_average = total / self.player_reviews.count
			round ? @player_accuracy_rating_average.round(1) : @player_accuracy_rating_average
		end
	end

	def player_effectiveness_average(round = true)
		if @player_effectiveness_rating_average
			round ? @player_effectiveness_rating_average.round(1) : @player_effectiveness_rating_average
		else
			total = 0
			self.player_reviews.each do |r|
				total += r.effectiveness_rating.to_f
			end
			@player_effectiveness_rating_average = total / self.player_reviews.count
			round ? @player_effectiveness_rating_average.round(1) : @player_effectiveness_rating_average
		end
	end

	def player_averages_total
		if @player_rating_averages_total
			@player_rating_averages_total.round(1)
		else
			@player_rating_averages_total =
				player_fun_average(false) +
				player_accuracy_average(false) +
				player_effectiveness_average(false)
			@player_rating_averages_total.round(1)
		end
	end
end
