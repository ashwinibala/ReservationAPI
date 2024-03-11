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

ActiveRecord::Schema[7.1].define(version: 2024_03_11_182748) do
  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.boolean "contact_concent"
    t.date "created_date"
    t.date "updated_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purposes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "criticality"
    t.string "make_year"
    t.string "brand"
    t.date "deleted_date"
    t.date "created_date"
    t.date "updated_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date "service_date"
    t.date "created_date"
    t.date "updated_date"
    t.bigint "vehicles_id"
    t.bigint "time_slots_id"
    t.bigint "purposes_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purposes_id"], name: "index_schedules_on_purposes_id"
    t.index ["time_slots_id"], name: "index_schedules_on_time_slots_id"
    t.index ["vehicles_id"], name: "index_schedules_on_vehicles_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.string "starttime"
    t.string "endtime"
    t.date "created_date"
    t.date "updated_date"
    t.date "deleted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vin"
    t.string "brand"
    t.string "name"
    t.string "licence_number"
    t.string "make_year"
    t.string "insurance_details"
    t.date "purchased_date"
    t.date "warrenty_date"
    t.date "created_date"
    t.date "updated_date"
    t.bigint "clients_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clients_id"], name: "index_vehicles_on_clients_id"
  end

  add_foreign_key "schedules", "purposes", column: "purposes_id"
  add_foreign_key "schedules", "time_slots", column: "time_slots_id"
  add_foreign_key "schedules", "vehicles", column: "vehicles_id"
  add_foreign_key "vehicles", "clients", column: "clients_id"
end
