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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20220531182044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",                                null: false
    t.text     "content"
    t.string   "slug",                                 null: false
    t.datetime "published_at"
    t.boolean  "pinned",               default: false, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "use_as_game_jam_page"
  end

  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "status",           limit: 255
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", unique: true, using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.text     "description"
    t.string   "website_url",            limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "boxart_file_name",       limit: 255
    t.string   "boxart_content_type",    limit: 255
    t.integer  "boxart_file_size"
    t.datetime "boxart_updated_at"
    t.string   "developer",              limit: 255
    t.string   "intended_audience",      limit: 255
    t.string   "concepts",               limit: 255
    t.string   "slug",                   limit: 255
    t.boolean  "disabled",                           default: true
    t.text     "teacher_info"
    t.boolean  "entertainment"
    t.integer  "approved_reviews_count",             default: 0
    t.string   "youtube_video_url",      limit: 255
  end

  add_index "games", ["slug"], name: "index_games_on_slug", unique: true, using: :btree

  create_table "player_reviews", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.string   "title",                limit: 255
    t.text     "content"
    t.float    "fun_rating"
    t.float    "accuracy_rating"
    t.float    "effectiveness_rating"
    t.string   "status",               limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "player_reviews", ["game_id", "user_id", "created_at"], name: "index_player_reviews_on_game_id_and_user_id_and_created_at", using: :btree

  create_table "screenshots", force: :cascade do |t|
    t.integer  "game_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "password_digest",        limit: 255
    t.string   "remember_token",         limit: 255
    t.boolean  "is_admin",                           default: false
    t.date     "birth_date"
    t.boolean  "disabled",                           default: false
    t.string   "parent_email",           limit: 255
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.boolean  "is_teacher",                         default: false
    t.boolean  "is_scientist",                       default: false
    t.boolean  "is_authoritative",                   default: false
    t.string   "description",            limit: 255
    t.boolean  "is_game_developer",                  default: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
    t.boolean  "dummy_password",                     default: false
    t.boolean  "prefers_gravatar",                   default: false
    t.string   "original_provider",      limit: 255
    t.boolean  "forum_approved",                     default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
