class AddApprovedReviewsAverageScoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :approved_reviews_average_total_rating, :float, default: 0, after: :approved_reviews_count
  end
end
