class AddIntendedAudienceToGames < ActiveRecord::Migration
  def change
    add_column :games, :intended_audience, :string
  end
end
