# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_28_065535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.string "domain", null: false
    t.string "redirect_url"
    t.string "endpoint_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "recaptcha_status", default: false, null: false
    t.index ["endpoint_id"], name: "index_forms_on_endpoint_id"
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.bigint "form_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["form_id"], name: "index_inquiries_on_form_id"
  end

  create_table "unconfirmed_emails", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "email", null: false
    t.string "encoded_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_unconfirmed_emails_on_email"
    t.index ["encoded_token"], name: "index_unconfirmed_emails_on_encoded_token", unique: true
    t.index ["user_id"], name: "index_unconfirmed_emails_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "forms", "users"
  add_foreign_key "inquiries", "forms"
  add_foreign_key "unconfirmed_emails", "users"
end
