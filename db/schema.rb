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

ActiveRecord::Schema.define(version: 2020_11_19_054931) do

  create_table "orders", force: :cascade do |t|
    t.string "content"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.datetime "time"
    t.integer "Technician_id"
    t.string "phone"
    t.string "technician_line_id"
    t.index ["Technician_id"], name: "index_orders_on_Technician_id"
  end

  create_table "technicians", force: :cascade do |t|
    t.string "line_id"
    t.string "name"
    t.string "comment"
    t.string "location"
    t.string "time"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_id"
    t.boolean "contact_flag"
  end

  create_table "todos", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "line_id"
    t.string "location"
    t.string "tel"
    t.boolean "privacy_flag"
    t.integer "location_flag"
    t.integer "service_step"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location1"
    t.string "location2"
    t.string "location3"
    t.string "content"
    t.datetime "time"
    t.string "name"
    t.string "phone"
    t.string "name_flag"
    t.string "phone_flag"
    t.integer "technician_id"
    t.string "contact_id"
    t.boolean "contact_flag"
    t.string "technician_line_id"
    t.index ["technician_id"], name: "index_users_on_technician_id"
  end

end
