class DropPlatforms < ActiveRecord::Migration
  def change
  	drop_table :platforms
  end
end
