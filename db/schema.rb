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

ActiveRecord::Schema.define(:version => 20120423183031) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "status"
  end

  create_table "games", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "website_url"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "boxart_file_name"
    t.string   "boxart_content_type"
    t.integer  "boxart_file_size"
    t.datetime "boxart_updated_at"
    t.string   "developer"
    t.string   "screenshot_1_file_name"
    t.string   "screenshot_1_content_type"
    t.integer  "screenshot_1_file_size"
    t.datetime "screenshot_1_updated_at"
    t.string   "screenshot_2_file_name"
    t.string   "screenshot_2_content_type"
    t.integer  "screenshot_2_file_size"
    t.datetime "screenshot_2_updated_at"
    t.string   "screenshot_3_file_name"
    t.string   "screenshot_3_content_type"
    t.integer  "screenshot_3_file_size"
    t.datetime "screenshot_3_updated_at"
    t.string   "screenshot_4_file_name"
    t.string   "screenshot_4_content_type"
    t.integer  "screenshot_4_file_size"
    t.datetime "screenshot_4_updated_at"
    t.string   "screenshot_5_file_name"
    t.string   "screenshot_5_content_type"
    t.integer  "screenshot_5_file_size"
    t.datetime "screenshot_5_updated_at"
  end

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
