class AddDisabledToGame < ActiveRecord::Migration
  def change
    add_column :games, :disabled, :boolean, default: true
  end
end
