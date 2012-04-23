class RemoveScreenshotsColumnsFromGames < ActiveRecord::Migration
  def change
  	remove_column :games, :screenshot_5_file_name
    remove_column :games, :screenshot_5_content_type
    remove_column :games, :screenshot_5_file_size
    remove_column :games, :screenshot_5_updated_at

    remove_column :games, :screenshot_4_file_name
    remove_column :games, :screenshot_4_content_type
    remove_column :games, :screenshot_4_file_size
    remove_column :games, :screenshot_4_updated_at

    remove_column :games, :screenshot_3_file_name
    remove_column :games, :screenshot_3_content_type
    remove_column :games, :screenshot_3_file_size
    remove_column :games, :screenshot_3_updated_at

    remove_column :games, :screenshot_2_file_name
    remove_column :games, :screenshot_2_content_type
    remove_column :games, :screenshot_2_file_size
    remove_column :games, :screenshot_2_updated_at

    remove_column :games, :screenshot_1_file_name
    remove_column :games, :screenshot_1_content_type
    remove_column :games, :screenshot_1_file_size
    remove_column :games, :screenshot_1_updated_at
  end
end
