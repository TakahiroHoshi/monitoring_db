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

ActiveRecord::Schema.define(version: 20150125022121) do

  create_table "comments", force: true do |t|
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "userstamp"
  end

  add_index "comments", ["comment"], name: "index_comments_on_comment"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "founded_date"
    t.date     "closed_date"
    t.string   "stage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hq_country"
    t.string   "multinational"
    t.string   "logo_image_file_name"
    t.string   "logo_image_content_type"
    t.integer  "logo_image_file_size"
    t.datetime "logo_image_updated_at"
  end

  add_index "companies", ["name", "stage"], name: "index_companies_on_name_and_stage"

  create_table "links", force: true do |t|
    t.string   "link_type"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "news_articles", force: true do |t|
    t.date     "date"
    t.string   "title"
    t.text     "content"
    t.text     "comment"
    t.string   "publisher"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "url"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "people", ["name"], name: "index_people_on_name"

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "released_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "hr_process"
    t.string   "rev_model"
  end

  add_index "products", ["name"], name: "index_products_on_name"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "id_num"
    t.string   "organization"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.boolean  "observer",        default: false
    t.string   "remember_token"
    t.boolean  "regular"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
