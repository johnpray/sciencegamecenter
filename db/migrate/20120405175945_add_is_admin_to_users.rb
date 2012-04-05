class AddIsAdminToUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :is_admin
    add_column :users, :is_admin, :boolean, default: false
  end
end
