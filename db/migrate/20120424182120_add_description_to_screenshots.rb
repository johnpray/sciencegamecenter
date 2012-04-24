class AddDescriptionToScreenshots < ActiveRecord::Migration
  def change
    add_column :screenshots, :description, :text
  end
end
