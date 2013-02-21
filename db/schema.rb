# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130221181450) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "status"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "games", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "website_url"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "boxart_file_name"
    t.string   "boxart_content_type"
    t.integer  "boxart_file_size"
    t.datetime "boxart_updated_at"
    t.string   "developer"
    t.string   "intended_audience"
    t.string   "concepts"
    t.string   "slug"
    t.boolean  "disabled",            :default => true
    t.text     "teacher_info"
    t.boolean  "entertainment"
  end

  add_index "games", ["slug"], :name => "index_games_on_slug", :unique => true

  create_table "player_reviews", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "fun_rating"
    t.integer  "accuracy_rating"
    t.integer  "effectiveness_rating"
    t.string   "status"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "player_reviews", ["game_id", "user_id", "created_at"], :name => "index_player_reviews_on_game_id_and_user_id_and_created_at"

  create_table "screenshots", :force => true do |t|
    t.integer  "game_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "is_admin",               :default => false
    t.date     "birth_date"
    t.boolean  "disabled",               :default => false
    t.string   "parent_email"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "is_teacher",             :default => false
    t.boolean  "is_scientist",           :default => false
    t.boolean  "is_authoritative",       :default => false
    t.string   "description"
    t.boolean  "is_game_developer",      :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "youtube_videos", :force => true do |t|
    t.string   "youtube_vi"
    t.integer  "game_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
