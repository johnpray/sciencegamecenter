class AddGameDeveloperRoleToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_game_developer, :boolean, default: false
  end
end
