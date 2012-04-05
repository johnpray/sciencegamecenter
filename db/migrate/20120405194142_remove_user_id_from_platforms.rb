class RemoveUserIdFromPlatforms < ActiveRecord::Migration
  def change
  	remove_column :platforms, :user_id
  end
end
