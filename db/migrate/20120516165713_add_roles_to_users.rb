class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_teacher, :boolean, default: false
    add_column :users, :is_scientist, :boolean, default: false
    add_column :users, :is_authoritative, :boolean, default: false
  end
end
