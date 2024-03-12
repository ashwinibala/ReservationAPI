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
  create_table "DateAvailability", force: :cascade do |t|
    t.date "service_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "phone"
    t.string "email"
    t.boolean "contact_concent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["phone"], name: "index_clients_on_phone", unique: true
  end

  create_table "purposes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "criticality"
    t.string "make_year"
    t.string "brand"
    t.date "deleted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date "service_date"
    t.date "completed_date"
    t.bigint "vehicles_id"
    t.bigint "timeslots_id"
    t.bigint "purposes_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purposes_id"], name: "index_schedules_on_purposes_id"
    t.index ["timeslots_id"], name: "index_schedules_on_timeslots_id"
    t.index ["vehicles_id"], name: "index_schedules_on_vehicles_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.string "starttime"
    t.string "endtime"
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
    t.bigint "clients_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clients_id"], name: "index_vehicles_on_clients_id"
  end

  add_foreign_key "schedules", "purposes", column: "purposes_id"
  add_foreign_key "schedules", "timeslots", column: "timeslots_id"
  add_foreign_key "schedules", "vehicles", column: "vehicles_id"
  add_foreign_key "vehicles", "clients", column: "clients_id"
end
