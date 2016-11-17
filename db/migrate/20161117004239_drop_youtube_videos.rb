class DropYoutubeVideos < ActiveRecord::Migration
  def up
    drop_table :youtube_videos
  end

  def down
    create_table :youtube_videos do |t|
      t.string :youtube_vi
      t.integer :game_id
      t.text :description

      t.timestamps
    end
  end
end
