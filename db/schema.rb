# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_02_172654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.string "subject"
    t.text "body"
    t.datetime "send_at"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_campaigns_on_group_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile_no"
    t.boolean "undeliverable", default: false
    t.boolean "bounce_count"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "email_deliveries", force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "client_id"
    t.string "status"
    t.string "failure_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_email_deliveries_on_campaign_id"
    t.index ["client_id"], name: "index_email_deliveries_on_client_id"
  end

  create_table "group_clients", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_group_clients_on_client_id"
    t.index ["group_id"], name: "index_group_clients_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "user"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "campaigns", "groups"
  add_foreign_key "campaigns", "users"
  add_foreign_key "clients", "users"
  add_foreign_key "email_deliveries", "campaigns"
  add_foreign_key "email_deliveries", "clients"
  add_foreign_key "group_clients", "clients"
  add_foreign_key "group_clients", "groups"
  add_foreign_key "groups", "users"
end
