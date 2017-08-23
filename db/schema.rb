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

ActiveRecord::Schema.define(version: 20170823140018) do

  create_table "answer_options", force: :cascade do |t|
    t.string   "answer",      limit: 255
    t.integer  "score",       limit: 2
    t.integer  "question_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "answer_options", ["question_id"], name: "index_answer_options_on_question_id", using: :btree

  create_table "assigned_surveys", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.boolean  "answered"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "users_id",          limit: 4
    t.integer  "user_id",           limit: 4
    t.integer  "course_id",         limit: 4
    t.integer  "survey_id",         limit: 4
    t.integer  "evaluated_user_id", limit: 4
  end

  add_index "assigned_surveys", ["course_id"], name: "index_assigned_surveys_on_course_id", using: :btree
  add_index "assigned_surveys", ["evaluated_user_id"], name: "index_assigned_surveys_on_evaluated_user_id", using: :btree
  add_index "assigned_surveys", ["survey_id"], name: "index_assigned_surveys_on_survey_id", using: :btree
  add_index "assigned_surveys", ["user_id"], name: "index_assigned_surveys_on_user_id", using: :btree
  add_index "assigned_surveys", ["users_id"], name: "index_assigned_surveys_on_users_id", using: :btree

  create_table "course_students", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "course_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "role",       limit: 255
    t.string   "group_name", limit: 255
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "semester",   limit: 1
    t.integer  "year",       limit: 4
    t.boolean  "status"
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "statement",  limit: 255
    t.string   "hint",       limit: 255
    t.integer  "score",      limit: 2
    t.integer  "survey_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "survey_results", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "assigned_survey_id", limit: 4
    t.integer  "answer_option_id",   limit: 4
  end

  add_index "survey_results", ["answer_option_id"], name: "index_survey_results_on_answer_option_id", using: :btree
  add_index "survey_results", ["assigned_survey_id"], name: "index_survey_results_on_assigned_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "roles_id",               limit: 4
    t.string   "name",                   limit: 255
    t.string   "lastname",               limit: 255
    t.integer  "phone",                  limit: 4
    t.boolean  "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "answer_options", "questions"
  add_foreign_key "assigned_surveys", "courses"
  add_foreign_key "assigned_surveys", "surveys"
  add_foreign_key "assigned_surveys", "users"
  add_foreign_key "assigned_surveys", "users", column: "evaluated_user_id"
  add_foreign_key "courses", "users"
  add_foreign_key "questions", "surveys"
  add_foreign_key "survey_results", "answer_options"
  add_foreign_key "survey_results", "assigned_surveys"
end
