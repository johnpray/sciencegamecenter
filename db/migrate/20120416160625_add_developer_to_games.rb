class AddDeveloperToGames < ActiveRecord::Migration
  def change
    add_column :games, :developer, :string
  end
end
