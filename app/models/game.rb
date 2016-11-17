require 'csv'

class Game < ActiveRecord::Base
  attr_accessible :title, :description, :website_url, :developer,
  								:intended_audience, :concepts, :disabled,
  								:boxart, :youtube_video_url,
                  :platform_list, :subject_list,
  								:cost_list, :intended_for_list, :developer_type_list,
                                :teacher_info, :entertainment

  default_scope order: 'games.updated_at DESC, games.title ASC'
  scope :enabled, where(disabled: false)
  scope :disabled, where(disabled: true)

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :player_reviews, dependent: :destroy
  has_many :screenshots,		dependent: :destroy

  belongs_to :user

  has_paper_trail

  acts_as_taggable_on :subjects, :platforms, :costs, :intended_fors, :developer_types

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

  def self.chart_data(start = 3.weeks.ago) #TODO: Make this not run a query for each date
    (start.to_date..Date.today).map do |date|
    	if (date == start.to_date) || (date == Date.today) || (Game.where(["date(created_at) = ?", date]).count > 0)
      {
        created_at: date,
        enabled_count: Game.enabled.where(["date(created_at) <= ?", date]).count,
        disabled_count: Game.disabled.where(["date(created_at) <= ?", date]).count
      }
    	else
    	{
        created_at: date,
      }
   		end
    end
  end

  def actual_player_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user && !r.user.is_expert? && !r.user.is_authoritative?
  	end
  	reviews
  end

  def authoritative_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user && r.user.is_authoritative?
  	end
  	reviews
  end

  def expert_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user && r.user.is_expert? && !r.user.is_authoritative?
  	end
  	reviews
  end

  def teacher_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user && r.user.is_teacher?
  	end
  	reviews
  end

  def scientist_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user.is_scientist?
  	end
  	reviews
  end

  def game_developer_reviews
  	reviews = []
  	self.player_reviews.each do |r|
  		reviews += [r] if r.user.is_game_developer?
  	end
  	reviews
  end

# PLAYER AVERAGES
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

# EXPERT AVERAGES
	def expert_fun_average(round = true)
		if self.approved_expert_reviews_count < 1
			-1
		elsif @expert_fun_rating_average
			round ? @expert_fun_rating_average.round(1) : @expert_fun_rating_average
		else
			total = 0
			count = 0
			self.expert_reviews.each do |r|
				total += r.fun_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@expert_fun_rating_average = total / count
			round ? @expert_fun_rating_average.round(1) : @expert_fun_rating_average
		end
	end

	def expert_accuracy_average(round = true)
		if self.approved_expert_reviews_count < 1
			-1
		elsif @expert_accuracy_rating_average
			round ? @expert_accuracy_rating_average.round(1) : @expert_accuracy_rating_average
		else
			total = 0
			count = 0
			self.expert_reviews.each do |r|
				total += r.accuracy_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@expert_accuracy_rating_average = total / count
			round ? @expert_accuracy_rating_average.round(1) : @expert_accuracy_rating_average
		end
	end

	def expert_effectiveness_average(round = true)
		if self.approved_expert_reviews_count < 1
			-1
		elsif @expert_effectiveness_rating_average
			round ? @expert_effectiveness_rating_average.round(1) : @expert_effectiveness_rating_average
		else
			total = 0
			count = 0
			self.expert_reviews.each do |r|
				total += r.effectiveness_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@expert_effectiveness_rating_average = total / count
			round ? @expert_effectiveness_rating_average.round(1) : @expert_effectiveness_rating_average
		end
	end

	def expert_averages_total
		if self.approved_expert_reviews_count < 1
			-1
		elsif @expert_rating_averages_total
			@expert_rating_averages_total.round(1)
		else
			@expert_rating_averages_total =
				expert_fun_average(false) +
				expert_accuracy_average(false) +
				expert_effectiveness_average(false)
			@expert_rating_averages_total.round(1)
		end
	end

	def approved_expert_reviews_count
		count = 0
		unless self.expert_reviews.nil?
			self.expert_reviews.each do |r|
				count += 1 if r.approved?
			end
		end
		count
	end

# AUTHORITATIVE AVERAGES
	def authoritative_fun_average(round = true)
		if self.approved_authoritative_reviews_count < 1
			-1
		elsif @authoritative_fun_rating_average
			round ? @authoritative_fun_rating_average.round(1) : @authoritative_fun_rating_average
		else
			total = 0
			count = 0
			self.authoritative_reviews.each do |r|
				total += r.fun_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@authoritative_fun_rating_average = total / count
			round ? @authoritative_fun_rating_average.round(1) : @authoritative_fun_rating_average
		end
	end

	def authoritative_accuracy_average(round = true)
		if self.approved_authoritative_reviews_count < 1
			-1
		elsif @authoritative_accuracy_rating_average
			round ? @authoritative_accuracy_rating_average.round(1) : @authoritative_accuracy_rating_average
		else
			total = 0
			count = 0
			self.authoritative_reviews.each do |r|
				total += r.accuracy_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@authoritative_accuracy_rating_average = total / count
			round ? @authoritative_accuracy_rating_average.round(1) : @authoritative_accuracy_rating_average
		end
	end

	def authoritative_effectiveness_average(round = true)
		if self.approved_authoritative_reviews_count < 1
			-1
		elsif @authoritative_effectiveness_rating_average
			round ? @authoritative_effectiveness_rating_average.round(1) : @authoritative_effectiveness_rating_average
		else
			total = 0
			count = 0
			self.authoritative_reviews.each do |r|
				total += r.effectiveness_rating.to_f if r.approved?
				count += 1 if r.approved?
			end
			@authoritative_effectiveness_rating_average = total / count
			round ? @authoritative_effectiveness_rating_average.round(1) : @authoritative_effectiveness_rating_average
		end
	end

	def authoritative_averages_total
		if self.approved_authoritative_reviews_count < 1
			-1
		elsif @authoritative_rating_averages_total
			@authoritative_rating_averages_total.round(1)
		else
			@authoritative_rating_averages_total =
				authoritative_fun_average(false) +
				authoritative_accuracy_average(false) +
				authoritative_effectiveness_average(false)
			@authoritative_rating_averages_total.round(1)
		end
	end

	def approved_authoritative_reviews_count
		count = 0
		unless self.authoritative_reviews.nil?
			self.authoritative_reviews.each do |r|
				count += 1 if r.approved?
			end
		end
		count
	end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      attrs = %w( title website_url developer subject_list concepts )
      csv << attrs
      all.each do |game|
        csv << attrs.map{|a| game.send(a)}
      end
    end
  end

end
