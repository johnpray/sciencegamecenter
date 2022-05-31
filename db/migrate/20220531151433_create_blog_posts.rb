class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title, null: false
      t.text :content

      t.string :slug, null: false

      t.datetime :published_at
      t.boolean :pinned, default: false, null: false

      t.timestamps null: false
    end

    add_index :blog_posts, :slug, unique: true
  end
end
