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
    t.bigint "vehicle_id"
    t.bigint "timeslot_id"
    t.bigint "purpose_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purpose_id"], name: "index_schedules_on_purpose_id"
    t.index ["timeslot_id"], name: "index_schedules_on_timeslot_id"
    t.index ["vehicle_id"], name: "index_schedules_on_vehicle_id"
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
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_vehicles_on_client_id"
    t.index ["licence_number"], name: "index_vehicles_on_licence_number", unique: true
    t.index ["vin"], name: "index_vehicles_on_vin", unique: true
  end

  add_foreign_key "schedules", "purposes"
  add_foreign_key "schedules", "timeslots"
  add_foreign_key "schedules", "vehicles"
  add_foreign_key "vehicles", "clients"
end
