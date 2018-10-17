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

ActiveRecord::Schema.define(version: 20181017045942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "intarray"

  create_table "auth_tokens", force: :cascade do |t|
    t.string "val"
    t.datetime "expire_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["val"], name: "index_auth_tokens_on_val"
  end

  create_table "brands", force: :cascade do |t|
    t.string "title"
    t.string "uid"
    t.integer "items_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.string "ancestry"
    t.boolean "has_items"
    t.integer "items_count"
    t.string "parent_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.boolean "disabled", default: false
    t.string "display_name"
    t.integer "sort"
    t.integer "columns_count", default: 1
    t.index ["uid"], name: "index_groups_on_uid", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "uid"
    t.integer "price"
    t.float "in_stock"
    t.text "discription"
    t.string "group_uid"
    t.integer "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.jsonb "image", default: {"exist"=>false}
    t.integer "likes_counter", default: 0
    t.text "description"
    t.index ["uid"], name: "index_items_on_uid", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "amount", default: 0
    t.integer "items_count", default: 0
    t.jsonb "items", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "received", default: false
    t.datetime "received_at"
    t.boolean "formed", default: false
    t.datetime "formed_at"
    t.text "comment"
    t.jsonb "info", default: {}
    t.boolean "is_paid", default: false
    t.boolean "payable", default: true
    t.datetime "paid_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "order_id"
    t.integer "amount"
    t.string "merchant_order_id"
    t.integer "status"
    t.jsonb "info", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_url"
  end

  create_table "smsmessages", force: :cascade do |t|
    t.integer "user_id"
    t.string "pin"
    t.string "tel"
    t.boolean "sended", default: false
    t.boolean "used", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "tel"
    t.boolean "created_from_1c", default: false
    t.string "role", default: "user"
    t.string "pin"
    t.integer "likes_counter", default: 0
    t.string "city"
    t.text "comment"
    t.integer "discount", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["tel"], name: "index_users_on_tel", unique: true
  end

end
