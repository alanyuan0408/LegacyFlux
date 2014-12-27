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

ActiveRecord::Schema.define(version: 20141227155621) do

  create_table "feedbanks", force: :cascade do |t|
    t.string   "item_id"
    t.string   "item_url"
    t.string   "item_title"
    t.datetime "item_date"
    t.text     "item_text"
    t.integer  "column_type"
    t.integer  "user_id"
    t.boolean  "approval_status", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                    default: "",    null: false
    t.string   "password_digest"
    t.string   "password_confirmation"
    t.string   "remember_token"
    t.boolean  "admin"
    t.integer  "email_frequency",          default: 7
    t.boolean  "news",                     default: true
    t.boolean  "research",                 default: true
    t.boolean  "jobs",                     default: true
    t.boolean  "events",                   default: true
    t.boolean  "expo_ticket",              default: false
    t.datetime "nextsend"
    t.string   "organization"
    t.string   "approval_message"
    t.boolean  "confirmationMail",         default: false
    t.string   "email_confirmation_token"
    t.boolean  "account_created",          default: false
    t.boolean  "account_selected",         default: false
    t.boolean  "content_creator",          default: false
    t.boolean  "student_account",          default: false
    t.boolean  "content_approved",         default: false
    t.boolean  "sent_approval",            default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "encrypted_password",       default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
