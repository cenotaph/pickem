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

ActiveRecord::Schema.define(version: 20131013131315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "week_id"
    t.integer  "user_id"
    t.string   "image"
    t.text     "content"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["week_id"], name: "index_comments_on_week_id", using: :btree

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.string   "iso4217"
    t.string   "country"
    t.string   "wikipedia_link"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "filename"
    t.string   "content_type"
    t.integer  "size",         limit: 8
    t.integer  "height"
    t.integer  "width"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["comment_id"], name: "index_images_on_comment_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: true do |t|
    t.integer  "year"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "basecurrency_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "provider"
    t.string   "name"
    t.string   "uid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",               default: false
    t.string   "avatar"
    t.string   "slug"
    t.string   "yahoo_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "week_users", force: true do |t|
    t.integer  "week_id"
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "final_score"
  end

  add_index "week_users", ["user_id"], name: "index_week_users_on_user_id", using: :btree
  add_index "week_users", ["week_id", "user_id"], name: "index_week_users_on_week_id_and_user_id", using: :btree
  add_index "week_users", ["week_id"], name: "index_week_users_on_week_id", using: :btree

  create_table "weeks", force: true do |t|
    t.integer  "season_id"
    t.string   "name"
    t.date     "closing_date"
    t.integer  "week_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
    t.float    "exchange_rate"
  end

  add_index "weeks", ["currency_id"], name: "index_weeks_on_currency_id", using: :btree
  add_index "weeks", ["season_id"], name: "index_weeks_on_season_id", using: :btree

end
