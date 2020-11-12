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

ActiveRecord::Schema.define(version: 2020_11_12_211353) do

  create_table "appearances", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "person_id"
    t.integer "character_id"
    t.string "name", limit: 255
    t.integer "importance"
    t.boolean "uncredited", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["character_id"], name: "index_appearances_on_character_id"
    t.index ["movie_id"], name: "index_appearances_on_movie_id"
    t.index ["person_id"], name: "index_appearances_on_person_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "alias", limit: 255
  end

  create_table "crews", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "person_id"
    t.string "role", limit: 255
    t.integer "importance", default: 0
    t.boolean "featured"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["movie_id"], name: "index_crews_on_movie_id"
    t.index ["person_id"], name: "index_crews_on_person_id"
  end

  create_table "earnings", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "domestic", default: 0
    t.integer "foreign", default: 0
    t.integer "worldwide", default: 0
    t.date "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["movie_id"], name: "index_earnings_on_movie_id"
  end

  create_table "franchise_members", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "franchise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["franchise_id"], name: "index_franchise_members_on_franchise_id"
    t.index ["movie_id"], name: "index_franchise_members_on_movie_id"
  end

  create_table "franchises", force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.index ["slug"], name: "index_franchises_on_slug", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.boolean "love"
    t.boolean "like"
    t.boolean "hate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["movie_id"], name: "index_likes_on_movie_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "movie_versions", force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.string "author_username", limit: 255
    t.index ["item_type", "item_id"], name: "index_movie_versions_on_item_type_and_item_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "year"
    t.integer "avg_v"
    t.integer "avg_n"
    t.integer "avg_l"
    t.integer "avg_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "poster_file_name", limit: 255
    t.string "poster_content_type", limit: 255
    t.integer "poster_file_size"
    t.datetime "poster_updated_at"
    t.text "summary"
    t.integer "director_id"
    t.integer "boxoffice_us"
    t.integer "boxoffice_foreign"
    t.bigint "boxoffice_worldwide"
    t.integer "runtime"
    t.string "mpaa", limit: 255
    t.date "released"
    t.float "avg_love"
    t.float "avg_like"
    t.float "avg_hate"
    t.string "spotify", limit: 255
    t.index ["director_id"], name: "index_movies_on_director_id"
    t.index ["slug"], name: "index_movies_on_slug", unique: true
    t.index ["title"], name: "index_movies_on_title"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "display_name", limit: 255
    t.date "born"
    t.date "died"
    t.string "twitter", limit: 255
    t.text "biography"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "promo_file_name", limit: 255
    t.string "promo_content_type", limit: 255
    t.integer "promo_file_size"
    t.datetime "promo_updated_at"
    t.string "name", limit: 255
    t.integer "boxoffice_us_cache", default: 0
    t.integer "boxoffice_foreign_cache", default: 0
    t.integer "boxoffice_worldwide_cache", default: 0
    t.index ["slug"], name: "index_people_on_slug", unique: true
  end

  create_table "quotes", force: :cascade do |t|
    t.string "text", limit: 255
    t.integer "movie_id"
    t.integer "appearance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["appearance_id"], name: "index_quotes_on_appearance_id"
    t.index ["movie_id"], name: "index_quotes_on_movie_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.integer "v"
    t.integer "n"
    t.integer "l"
    t.integer "at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["movie_id"], name: "index_ratings_on_movie_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "movie_id"
    t.string "code", limit: 255
    t.boolean "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "trailers", force: :cascade do |t|
    t.integer "movie_id"
    t.string "code", limit: 255
    t.boolean "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["movie_id"], name: "index_trailers_on_movie_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.string "foreign_type"
    t.index ["foreign_key_name", "foreign_key_id", "foreign_type"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.text "object_changes", limit: 1073741823
    t.string "author_username"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

end
