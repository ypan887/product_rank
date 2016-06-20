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

ActiveRecord::Schema.define(version: 20160612225937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archives", force: :cascade do |t|
    t.date  "date",               null: false
    t.jsonb "posts", default: {}, null: false
  end

  add_index "archives", ["posts"], name: "index_archives_on_posts", using: :gin

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "widget_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["widget_id"], name: "index_order_details_on_widget_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "order_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "orders", ["order_no"], name: "index_orders_on_order_no", using: :btree

  create_table "widgets", force: :cascade do |t|
    t.string   "color"
    t.string   "plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "widgets", ["color", "plan"], name: "index_widgets_on_color_and_plan", unique: true, using: :btree

  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "widgets"
end
