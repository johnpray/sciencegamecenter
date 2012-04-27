class AddConceptsToGames < ActiveRecord::Migration
  def change
    add_column :games, :concepts, :string
  end
end
