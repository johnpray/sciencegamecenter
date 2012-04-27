class CreateYoutubeVideos < ActiveRecord::Migration
  def change
    create_table :youtube_videos do |t|
      t.string :youtube_vi
      t.integer :game_id
      t.text :description

      t.timestamps
    end
  end
end
