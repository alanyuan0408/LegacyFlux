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

ActiveRecord::Schema.define(version: 20150112034146) do

  create_table "account_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "student_account", default: false
    t.boolean  "admin",           default: false
    t.boolean  "news_admin",      default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "account_settings", ["user_id"], name: "index_account_settings_on_user_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

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

  create_table "mail_settings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "email_frequency", default: 7
    t.boolean  "news",            default: true
    t.boolean  "research",        default: true
    t.boolean  "jobs",            default: true
    t.boolean  "events",          default: true
    t.boolean  "expo_ticket",     default: false
    t.datetime "nextsend"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "mail_settings", ["user_id"], name: "index_mail_settings_on_user_id"

  create_table "news_letter_entries", force: :cascade do |t|
    t.integer  "news_letter_mail_id"
    t.string   "entry_title"
    t.text     "entry_text"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "item_id"
    t.integer  "ordering"
  end

  add_index "news_letter_entries", ["news_letter_mail_id"], name: "index_news_letter_entries_on_news_letter_mail_id"

  create_table "news_letter_mails", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "intro_message"
  end

  add_index "news_letter_mails", ["user_id"], name: "index_news_letter_mails_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "users"
    t.boolean  "confirmationMail",         default: false
    t.string   "email_confirmation_token"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "email",                    default: "",    null: false
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
