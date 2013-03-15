class AddDummyPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dummy_password, :boolean, default: false
  end
end
