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

ActiveRecord::Schema.define(version: 2018_11_01_012117) do

  create_table "audits", force: :cascade do |t|
    t.string "type"
    t.string "site", null: false
    t.string "address", null: false
    t.date "date", default: "2018-11-01", null: false
    t.string "products", null: false
    t.boolean "validated", default: false, null: false
    t.float "rating", default: 0.0, null: false
    t.float "price", default: 0.0, null: false
    t.integer "auditor_id"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditor_id"], name: "index_audits_on_auditor_id"
    t.index ["client_id"], name: "index_audits_on_client_id"
  end

  create_table "conserns", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "source_id", null: false
    t.integer "destiny_id", null: false
    t.text "description", default: "", null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "type"
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.boolean "validated", default: false, null: false
    t.string "address", default: "", null: false
    t.string "company", default: "", null: false
    t.float "rating", default: 0.0, null: false
    t.string "qualifications", default: "", null: false
    t.string "cv", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["validated"], name: "index_users_on_validated"
  end

end
