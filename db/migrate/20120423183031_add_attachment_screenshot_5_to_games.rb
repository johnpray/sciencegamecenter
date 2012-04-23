class AddAttachmentScreenshot5ToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :screenshot_5_file_name, :string
    add_column :games, :screenshot_5_content_type, :string
    add_column :games, :screenshot_5_file_size, :integer
    add_column :games, :screenshot_5_updated_at, :datetime
  end

  def self.down
    remove_column :games, :screenshot_5_file_name
    remove_column :games, :screenshot_5_content_type
    remove_column :games, :screenshot_5_file_size
    remove_column :games, :screenshot_5_updated_at
  end
end
