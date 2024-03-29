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

ActiveRecord::Schema.define(version: 20140531140756) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.boolean  "editing"
    t.integer  "user_id"
  end

  create_table "comments", force: true do |t|
    t.text     "value"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  create_table "entries", force: true do |t|
    t.integer  "round_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "value"
  end

  create_table "histories", force: true do |t|
    t.integer  "sprint_id"
    t.float    "estimation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "story_id"
    t.boolean  "belongs_sprint"
  end

  create_table "pokers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "story_id"
    t.boolean  "active"
  end

  create_table "posts", force: true do |t|
    t.text     "value"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "topic"
  end

  create_table "priorities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productowners", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "scrummaster_id"
    t.integer  "productowner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", force: true do |t|
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poker_id"
    t.integer  "user_id"
    t.boolean  "active"
  end

  create_table "sprints", force: true do |t|
    t.date     "start"
    t.date     "end"
    t.integer  "velocity"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.text     "description"
    t.text     "test"
    t.integer  "priority_id"
    t.integer  "value"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "timeestimates"
    t.integer  "sprint_id"
    t.text     "note"
    t.integer  "finished_in_sprint"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assigned_to"
    t.integer  "story_id"
    t.boolean  "completed",       default: false
    t.integer  "proposed_id"
    t.float    "time_estimation"
    t.datetime "assigned_date"
    t.datetime "startwork"
  end

  create_table "teammembers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.integer  "role_id"
    t.integer  "activeproject_id"
    t.boolean  "active",           default: true
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "workloads", force: true do |t|
    t.integer  "sprint_id"
    t.float    "estimation"
    t.integer  "project_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worktimes", force: true do |t|
    t.datetime "start"
    t.float    "done"
    t.float    "remaining"
    t.date     "day"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "task_estimation"
    t.integer  "sprint_id"
    t.integer  "story_id"
  end

end
