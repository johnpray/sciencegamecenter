class AddForumApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forum_approved, :boolean, default: false
  end
end
