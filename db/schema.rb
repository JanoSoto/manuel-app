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

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_options", force: :cascade do |t|
    t.string   "answer"
    t.integer  "score",       limit: 2
    t.integer  "question_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "answer_options", ["question_id"], name: "index_answer_options_on_question_id", using: :btree

  create_table "assigned_surveys", force: :cascade do |t|
    t.string   "name"
    t.boolean  "answered"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "survey_id"
    t.integer  "evaluated_user_id"
  end

  add_index "assigned_surveys", ["course_id"], name: "index_assigned_surveys_on_course_id", using: :btree
  add_index "assigned_surveys", ["evaluated_user_id"], name: "index_assigned_surveys_on_evaluated_user_id", using: :btree
  add_index "assigned_surveys", ["survey_id"], name: "index_assigned_surveys_on_survey_id", using: :btree
  add_index "assigned_surveys", ["user_id"], name: "index_assigned_surveys_on_user_id", using: :btree

  create_table "course_students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "course_id"
    t.integer  "user_id"
    t.string   "role"
    t.string   "group_name"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "semester",   limit: 2
    t.integer  "year",       limit: 2
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "statement"
    t.string   "hint"
    t.integer  "score",      limit: 2
    t.integer  "survey_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_results", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "assigned_survey_id"
    t.integer  "answer_option_id"
  end

  add_index "survey_results", ["answer_option_id"], name: "index_survey_results_on_answer_option_id", using: :btree
  add_index "survey_results", ["assigned_survey_id"], name: "index_survey_results_on_assigned_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "roles_id"
    t.string   "name"
    t.string   "lastname"
    t.integer  "phone"
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
