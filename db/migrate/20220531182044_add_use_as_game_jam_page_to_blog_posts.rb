class AddUseAsGameJamPageToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :use_as_game_jam_page, :boolean
  end
end
