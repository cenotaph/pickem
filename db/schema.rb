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

ActiveRecord::Schema.define(version: 20160703085828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "week_id"
    t.integer  "user_id"
    t.string   "image",      limit: 255
    t.text     "content"
    t.string   "status",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
    t.index ["week_id"], name: "index_comments_on_week_id", using: :btree
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "iso4217",        limit: 255
    t.string   "country",        limit: 255
    t.string   "wikipedia_link", limit: 255
    t.string   "symbol",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: :cascade do |t|
    t.string   "filename",     limit: 255
    t.string   "content_type", limit: 255
    t.bigint   "size"
    t.integer  "height"
    t.integer  "width"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["comment_id"], name: "index_images_on_comment_id", using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "slug",       limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer  "year"
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "basecurrency_id"
    t.boolean  "finished",                    default: false, null: false
    t.string   "slug"
  end

  create_table "seasons_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "season_id"
    t.float   "final_luck"
    t.index ["season_id"], name: "index_seasons_users_on_season_id", using: :btree
    t.index ["user_id", "season_id"], name: "index_seasons_users_on_user_id_and_season_id", using: :btree
    t.index ["user_id"], name: "index_seasons_users_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "provider",               limit: 255
    t.string   "name",                   limit: 255
    t.string   "uid",                    limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                           default: false
    t.string   "avatar",                 limit: 255
    t.string   "slug",                   limit: 255
    t.string   "yahoo_name",             limit: 255
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "week_users", force: :cascade do |t|
    t.integer  "week_id"
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "final_score"
    t.index ["user_id"], name: "index_week_users_on_user_id", using: :btree
    t.index ["week_id", "user_id"], name: "index_week_users_on_week_id_and_user_id", using: :btree
    t.index ["week_id"], name: "index_week_users_on_week_id", using: :btree
  end

  create_table "weeks", force: :cascade do |t|
    t.integer  "season_id"
    t.string   "name",          limit: 255
    t.date     "closing_date"
    t.integer  "week_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "currency_id"
    t.float    "exchange_rate"
    t.index ["currency_id"], name: "index_weeks_on_currency_id", using: :btree
    t.index ["season_id"], name: "index_weeks_on_season_id", using: :btree
  end

end
