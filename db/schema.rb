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

ActiveRecord::Schema.define(version: 20150624215158) do

  create_table "indeed_results", force: true do |t|
    t.float    "score"
    t.integer  "job_total_1"
    t.integer  "job_total_2"
    t.text     "job_listing_1"
    t.text     "job_listing_2"
    t.text     "job_raw_1"
    t.text     "job_raw_2"
    t.integer  "search_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "indeed_results", ["search_id"], name: "index_indeed_results_on_search_id"

  create_table "meetups", force: true do |t|
    t.text     "name"
    t.float    "score"
    t.integer  "total_members"
    t.integer  "search_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "total_meetups"
    t.float    "avg_relevancy"
  end

  add_index "meetups", ["search_id"], name: "index_meetups_on_search_id"

  create_table "pages", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "searches", force: true do |t|
    t.string   "job1"
    t.string   "job2"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "job_scale"
    t.text     "meetup_interests"
  end

  add_index "searches", ["user_id", "created_at"], name: "index_searches_on_user_id_and_created_at"
  add_index "searches", ["user_id"], name: "index_searches_on_user_id"

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
