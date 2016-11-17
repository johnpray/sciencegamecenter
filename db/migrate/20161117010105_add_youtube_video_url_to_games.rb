class AddYoutubeVideoUrlToGames < ActiveRecord::Migration
  def change
    add_column :games, :youtube_video_url, :string
  end
end
