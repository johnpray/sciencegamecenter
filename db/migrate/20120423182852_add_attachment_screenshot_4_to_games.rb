class AddAttachmentScreenshot4ToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :screenshot_4_file_name, :string
    add_column :games, :screenshot_4_content_type, :string
    add_column :games, :screenshot_4_file_size, :integer
    add_column :games, :screenshot_4_updated_at, :datetime
  end

  def self.down
    remove_column :games, :screenshot_4_file_name
    remove_column :games, :screenshot_4_content_type
    remove_column :games, :screenshot_4_file_size
    remove_column :games, :screenshot_4_updated_at
  end
end
