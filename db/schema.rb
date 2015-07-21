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

ActiveRecord::Schema.define(version: 20150721232541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: true do |t|
    t.integer  "person_id"
    t.integer  "movie_id"
    t.string   "name"
    t.integer  "importance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "characters", ["movie_id"], name: "index_characters_on_movie_id", using: :btree
  add_index "characters", ["person_id"], name: "index_characters_on_person_id", using: :btree

  create_table "crews", force: true do |t|
    t.integer  "movie_id"
    t.integer  "person_id"
    t.string   "role"
    t.integer  "importance", default: 0
    t.boolean  "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crews", ["movie_id"], name: "index_crews_on_movie_id", using: :btree
  add_index "crews", ["person_id"], name: "index_crews_on_person_id", using: :btree

  create_table "earnings", force: true do |t|
    t.integer  "movie_id"
    t.integer  "domestic",   default: 0
    t.integer  "foreign",    default: 0
    t.integer  "worldwide",  default: 0
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "earnings", ["movie_id"], name: "index_earnings_on_movie_id", using: :btree

  create_table "franchise_members", force: true do |t|
    t.integer  "movie_id"
    t.integer  "franchise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "franchise_members", ["franchise_id"], name: "index_franchise_members_on_franchise_id", using: :btree
  add_index "franchise_members", ["movie_id"], name: "index_franchise_members_on_movie_id", using: :btree

  create_table "franchises", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "franchises", ["slug"], name: "index_franchises_on_slug", unique: true, using: :btree

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.boolean  "love"
    t.boolean  "like"
    t.boolean  "hate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["movie_id"], name: "index_likes_on_movie_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "movie_versions", force: true do |t|
    t.string   "item_type",       null: false
    t.integer  "item_id",         null: false
    t.string   "event",           null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.string   "author_username"
  end

  add_index "movie_versions", ["item_type", "item_id"], name: "index_movie_versions_on_item_type_and_item_id", using: :btree

  create_table "movies", force: true do |t|
    t.string   "title"
    t.integer  "year"
    t.integer  "avg_v"
    t.integer  "avg_n"
    t.integer  "avg_l"
    t.integer  "avg_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.text     "summary"
    t.integer  "director_id"
    t.integer  "boxoffice_us",        limit: 8
    t.integer  "boxoffice_foreign",   limit: 8
    t.integer  "boxoffice_worldwide", limit: 8
    t.integer  "runtime"
    t.string   "mpaa"
    t.date     "released"
    t.float    "avg_love"
    t.float    "avg_like"
    t.float    "avg_hate"
    t.string   "spotify"
  end

  add_index "movies", ["director_id"], name: "index_movies_on_director_id", using: :btree
  add_index "movies", ["slug"], name: "index_movies_on_slug", unique: true, using: :btree
  add_index "movies", ["title"], name: "index_movies_on_title", using: :btree

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name"
    t.date     "born"
    t.date     "died"
    t.string   "twitter"
    t.text     "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "promo_file_name"
    t.string   "promo_content_type"
    t.integer  "promo_file_size"
    t.datetime "promo_updated_at"
    t.string   "name"
  end

  add_index "people", ["slug"], name: "index_people_on_slug", unique: true, using: :btree

  create_table "quotes", force: true do |t|
    t.string   "text"
    t.integer  "movie_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["character_id"], name: "index_quotes_on_character_id", using: :btree
  add_index "quotes", ["movie_id"], name: "index_quotes_on_movie_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.integer  "v"
    t.integer  "n"
    t.integer  "l"
    t.integer  "at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "movie_id"
    t.string   "code"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["movie_id"], name: "index_reviews_on_movie_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trailers", force: true do |t|
    t.integer  "movie_id"
    t.string   "code"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trailers", ["movie_id"], name: "index_trailers_on_movie_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
