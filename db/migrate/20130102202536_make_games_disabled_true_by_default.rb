class MakeGamesDisabledTrueByDefault < ActiveRecord::Migration
  def up
  	change_column :games, :disabled, :boolean, default: true
  end

  def down
  	change_column :games, :disabled, :boolean, default: nil
  end
end
