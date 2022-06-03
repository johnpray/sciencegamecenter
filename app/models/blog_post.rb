class BlogPost < ActiveRecord::Base
  attr_accessible :title, :content, :published_at, :pinned, :topic_list, :use_as_game_jam_page

  scope :published, -> { where("published_at <= ?", Time.now).order(published_at: :desc) }

  validates :title, presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  acts_as_taggable_on :topics

  has_paper_trail

  def published_at_string
    if published_at.blank?
      "Unpublished"
    else

      if published_at.future?
        datetime_string = published_at.
          in_time_zone('Eastern Time (US & Canada)').
          strftime('%B %-d, %Y at %-l:%M %p %Z')

        "Will publish on #{datetime_string}"

      else
        datetime_string = published_at.
          in_time_zone('Eastern Time (US & Canada)').
          strftime('%B %-d, %Y')

        datetime_string
      end
    end
  end
end
