class AddEdutainmentToGames < ActiveRecord::Migration
  def change
    add_column :games, :edutainment, :boolean
  end
end
