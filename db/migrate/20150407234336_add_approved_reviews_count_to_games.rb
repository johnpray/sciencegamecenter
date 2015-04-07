class AddApprovedReviewsCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :approved_reviews_count, :integer, default: 0
  end
end
