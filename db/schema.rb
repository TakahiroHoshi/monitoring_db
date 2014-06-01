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

ActiveRecord::Schema.define(version: 20140601060424) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.binary   "logo"
    t.text     "description"
    t.date     "founded_date"
    t.date     "closed_date"
    t.string   "stage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name", "stage"], name: "index_companies_on_name_and_stage"

  create_table "companies_tags", force: true do |t|
    t.integer  "company_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies_tags", ["company_id", "tag_id"], name: "index_companies_tags_on_company_id_and_tag_id"

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  add_index "people", ["name"], name: "index_people_on_name"

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag"

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
