class AddOriginalProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :original_provider, :string
  end
end
