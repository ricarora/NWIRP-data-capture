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

ActiveRecord::Schema.define(version: 20150213201443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessments", force: true do |t|
    t.date     "date"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_reliefs", force: true do |t|
    t.string   "relief_name"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "last_name"
    t.string   "first_name"
    t.string   "nationality"
    t.string   "ethnicity",               limit: nil, array: true
    t.string   "gender"
    t.string   "represented"
    t.boolean  "drru_case"
    t.string   "a_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_a_number"
    t.string   "encrypted_a_number_salt"
    t.string   "encrypted_a_number_iv"
  end

  create_table "conviction_grounds", force: true do |t|
    t.string   "gor_name"
    t.integer  "conviction_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "convictions", force: true do |t|
    t.string   "crime_name"
    t.string   "subsection"
    t.integer  "sentence"
    t.string   "ij_name"
    t.string   "nta_charges"
    t.date     "ij_decision_date"
    t.text     "ij_finding"
    t.integer  "client_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_committed"
    t.string   "rcw"
    t.boolean  "dv_on_roc"
  end

  create_table "relief_soughts", id: false, force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relief_soughts", ["name"], name: "index_relief_soughts_on_name", unique: true, using: :btree

  create_table "removability_grounds", id: false, force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "removability_grounds", ["name"], name: "index_removability_grounds_on_name", unique: true, using: :btree

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
    t.boolean  "admin"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
