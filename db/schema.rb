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

ActiveRecord::Schema.define(version: 2019_01_15_000526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_notifications", force: :cascade do |t|
    t.string "body", default: "", null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audit_requests", force: :cascade do |t|
    t.string "company", default: "", null: false
    t.string "address", default: "", null: false
    t.string "products", default: "", null: false
    t.date "date", null: false
    t.bigint "client_id"
    t.boolean "validated", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_audit_requests_on_client_id"
  end

  create_table "audits", force: :cascade do |t|
    t.string "type"
    t.date "date", default: "2019-01-19", null: false
    t.string "products", default: "", null: false
    t.boolean "validated", default: false, null: false
    t.bigint "auditor_id"
    t.float "price", default: 0.0, null: false
    t.string "summary", default: "", null: false
    t.float "fee", default: 0.0, null: false
    t.integer "rating_sum", default: 0, null: false
    t.integer "ratings", default: 0, null: false
    t.string "report", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditor_id"], name: "index_audits_on_auditor_id"
  end

  create_table "consents", force: :cascade do |t|
    t.string "type"
    t.string "body", default: "", null: false
    t.boolean "active", default: false, null: false
    t.date "date", default: "2019-01-19", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forgot_passwords", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_forgot_passwords_on_token"
    t.index ["user_id"], name: "index_forgot_passwords_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "destiny_id", null: false
    t.bigint "audit_id", null: false
    t.text "body", default: "", null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audit_id"], name: "index_messages_on_audit_id"
    t.index ["destiny_id"], name: "index_messages_on_destiny_id"
    t.index ["source_id"], name: "index_messages_on_source_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.float "price", default: 0.0, null: false
    t.bigint "report_id", null: false
    t.bigint "client_id", null: false
    t.bigint "auditor_id", null: false
    t.integer "rating", default: -1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditor_id"], name: "index_purchases_on_auditor_id"
    t.index ["client_id"], name: "index_purchases_on_client_id"
    t.index ["report_id"], name: "index_purchases_on_report_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.float "price", default: 0.0, null: false
    t.bigint "plan_id", null: false
    t.bigint "client_id", null: false
    t.bigint "auditor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditor_id"], name: "index_reservations_on_auditor_id"
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["plan_id"], name: "index_reservations_on_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type"
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "password", default: "", null: false
    t.boolean "validated", default: false, null: false
    t.boolean "terms_of_service", default: false, null: false
    t.string "address", default: "", null: false
    t.string "company", default: "", null: false
    t.string "country", default: "", null: false
    t.integer "rating_sum", default: 0, null: false
    t.integer "ratings", default: 0, null: false
    t.string "qualifications", default: "", null: false
    t.string "cv", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["validated"], name: "index_users_on_validated"
  end

  add_foreign_key "messages", "users", column: "destiny_id"
  add_foreign_key "messages", "users", column: "source_id"
end
