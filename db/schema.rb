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

ActiveRecord::Schema.define(version: 20180622132036) do

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.boolean "online", default: false
    t.integer "current_sector"
    t.integer "credits", default: 0
    t.integer "turns", default: 0
    t.integer "fighters", default: 0
    t.integer "exp", default: 0
    t.integer "holds", default: 0
    t.integer "organics", default: 0
    t.integer "equipment", default: 0
    t.integer "colonists", default: 0
    t.string "ship_name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "sectors", force: :cascade do |t|
    t.integer "planet_type_id"
    t.string "planet_name"
    t.integer "colonists", default: 0
    t.integer "ore", default: 0
    t.integer "equipment", default: 0
    t.integer "fighters", default: 0
    t.integer "organics", default: 0
    t.integer "owned_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_type_id"], name: "index_sectors_on_planet_type_id"
  end

  create_table "warps", force: :cascade do |t|
    t.integer "origin_id"
    t.integer "dest_id"
  end

end
