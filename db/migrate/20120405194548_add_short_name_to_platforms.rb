class AddShortNameToPlatforms < ActiveRecord::Migration
  def change
    add_column :platforms, :short_name, :string
  end
end
