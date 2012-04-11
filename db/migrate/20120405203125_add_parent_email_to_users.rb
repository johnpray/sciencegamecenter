class AddParentEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parent_email, :string
  end
end
