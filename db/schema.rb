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

ActiveRecord::Schema.define(version: 20180719150722) do

  create_table "event_store_events", id: :string, limit: 36, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "event_type", null: false
    t.text "metadata"
    t.text "data", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_on_created_at"
  end

  create_table "event_store_events_in_streams", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "stream", null: false
    t.integer "position"
    t.string "event_id", null: false
    t.datetime "created_at", null: false
    t.index ["created_at"], name: "index_event_store_events_in_streams_on_created_at"
    t.index ["stream", "event_id"], name: "index_event_store_events_in_streams_on_stream_and_event_id", unique: true
    t.index ["stream", "position"], name: "index_event_store_events_in_streams_on_stream_and_position", unique: true
  end

  create_table "offers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "transaction_id"
    t.integer "amount", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.index ["transaction_id"], name: "index_offers_on_transaction_id"
  end

  create_table "planet_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_planet_types_on_id"
  end

  create_table "players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "username"
    t.boolean "online", default: false
    t.integer "current_sector", unsigned: true
    t.integer "credits", default: 0, unsigned: true
    t.integer "turns", default: 0, unsigned: true
    t.integer "fighters", default: 0, unsigned: true
    t.integer "exp", default: 0, unsigned: true
    t.integer "holds", default: 0, unsigned: true
    t.integer "organics", default: 0, unsigned: true
    t.integer "equipment", default: 0, unsigned: true
    t.integer "colonists", default: 0, unsigned: true
    t.string "ship_name"
    t.string "email"
    t.string "password_digest"
    t.integer "alignment"
    t.integer "ship_type_id", unsigned: true
  end

  create_table "ports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "port_class", null: false
    t.string "name", null: false
    t.integer "accumulated_trading_credits", default: 0, unsigned: true
    t.integer "sector_id", null: false
    t.integer "ore_productivity", default: 0, unsigned: true
    t.integer "organics_productivity", default: 0, unsigned: true
    t.integer "equipment_productivity", default: 0, unsigned: true
    t.integer "ore_mcic", default: 0
    t.integer "organics_mcic", default: 0
    t.integer "equipment_mcic", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ore_qty", unsigned: true
    t.integer "equipment_qty", unsigned: true
    t.integer "organics_qty", unsigned: true
    t.index ["sector_id"], name: "index_ports_on_sector_id"
  end

  create_table "sectors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "fighters", default: 0
    t.integer "organics", default: 0
    t.integer "owned_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "home_sector", default: false
    t.boolean "federation_space", default: false
    t.index ["id"], name: "index_sectors_on_id"
  end

  create_table "ship_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_holds", unsigned: true
    t.integer "cost", unsigned: true
    t.integer "turns_per_warp", unsigned: true
    t.integer "base_holds", unsigned: true
    t.integer "max_fighters", unsigned: true
    t.integer "max_fighters_per_attack", unsigned: true
    t.boolean "long_range_scan", default: false
    t.index ["id"], name: "index_ship_types_on_id"
  end

  create_table "ships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "player_id"
    t.integer "ship_type_id"
    t.string "banner"
    t.string "serial"
    t.integer "total_holds", unsigned: true
    t.integer "empty_holds", unsigned: true
    t.integer "shield_points", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["player_id"], name: "index_ships_on_player_id"
    t.index ["ship_type_id"], name: "index_ships_on_ship_type_id"
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "port_id"
    t.integer "player_id"
    t.boolean "open", default: true
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "commodity"
    t.string "qty"
    t.string "trade_type"
    t.integer "initial_offer"
    t.index ["player_id"], name: "index_transactions_on_player_id"
    t.index ["port_id"], name: "index_transactions_on_port_id"
  end

  create_table "warp_graph", id: false, force: :cascade, options: "ENGINE=OQGRAPH DEFAULT CHARSET=latin1 `data_table`=warps `origid`=origin_id `destid`=dest_id" do |t|
    t.string "latch", limit: 32
    t.bigint "origid", unsigned: true
    t.bigint "destid", unsigned: true
    t.float "weight", limit: 53
    t.bigint "seq", unsigned: true
    t.bigint "linkid", unsigned: true
    t.index ["latch", "destid", "origid"], name: "latch_2", using: :hash
    t.index ["latch", "origid", "destid"], name: "latch", using: :hash
  end

  create_table "warps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "origin_id", null: false
    t.integer "dest_id", null: false
    t.index ["dest_id"], name: "index_warps_on_dest_id"
    t.index ["origin_id"], name: "index_warps_on_origin_id"
  end

end
