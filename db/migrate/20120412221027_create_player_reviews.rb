class CreatePlayerReviews < ActiveRecord::Migration
  def change
    create_table :player_reviews do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :title
      t.text :content
      t.integer :fun_rating
      t.integer :accuracy_rating
      t.integer :effectiveness_rating
      t.string :status

      t.timestamps
    end
    add_index :player_reviews, [:game_id, :user_id, :created_at]
  end
end
