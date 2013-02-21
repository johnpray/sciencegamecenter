class RenameEdutainmentToEntertainment < ActiveRecord::Migration
  def change
    rename_column :games, :edutainment, :entertainment
  end
end
