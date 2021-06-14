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

ActiveRecord::Schema.define(version: 2021_06_13_074113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "finished_tables", force: :cascade do |t|
    t.bigint "technicians_id"
    t.bigint "work_orders_id"
    t.bigint "locations_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["locations_id"], name: "index_finished_tables_on_locations_id"
    t.index ["technicians_id"], name: "index_finished_tables_on_technicians_id"
    t.index ["work_orders_id"], name: "index_finished_tables_on_work_orders_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "technicians", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "work_orders", force: :cascade do |t|
    t.integer "technician_id"
    t.integer "location_id"
    t.string "time"
    t.integer "duration"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "finished_tables", "locations", column: "locations_id"
  add_foreign_key "finished_tables", "technicians", column: "technicians_id"
  add_foreign_key "finished_tables", "work_orders", column: "work_orders_id"
end
