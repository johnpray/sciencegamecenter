class AddPrefersGravatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :prefers_gravatar, :boolean, default: false
  end
end
