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

ActiveRecord::Schema.define(version: 20180828152245) do

  create_table "corporations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", null: false
    t.integer "ceo_id", null: false
    t.integer "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "holds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "ship_id", null: false, unsigned: true
    t.integer "qty", null: false, unsigned: true
    t.string "contents", null: false
    t.index ["ship_id"], name: "index_holds_on_ship_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "from_id", null: false
    t.integer "to_id", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.index ["from_id"], name: "index_messages_on_from_id"
    t.index ["to_id"], name: "index_messages_on_to_id"
  end

  create_table "moons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.integer "planet_id", null: false
    t.index ["planet_id"], name: "index_moons_on_planet_id"
  end

  create_table "offers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.integer "transaction_id"
    t.integer "amount", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.boolean "final", default: false
    t.index ["transaction_id"], name: "index_offers_on_transaction_id"
  end

  create_table "planet_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.string "classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "colonists_ore_ratio"
    t.integer "colonists_organics_ratio"
    t.integer "colonists_equipment_ratio"
    t.integer "colonists_fighters_ratio"
    t.integer "max_colonists_fuel_ore"
    t.integer "max_colonists_organics"
    t.integer "max_colonists_equipment"
    t.integer "max_product_ore"
    t.integer "max_product_organics"
    t.integer "max_product_equipment"
    t.integer "max_product_fighters", default: 0
    t.text "description"
    t.index ["id"], name: "index_planet_types_on_id"
  end

  create_table "planets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name"
    t.integer "planet_type_id"
    t.integer "owner_id"
    t.integer "creator_id"
    t.integer "sector_id"
    t.integer "ore_colonists", default: 0, null: false
    t.integer "organics_colonists", default: 0, null: false
    t.integer "equipment_colonists", default: 0, null: false
    t.integer "unassigned_colonists", default: 0, null: false
    t.integer "ore", default: 0, null: false
    t.integer "organics", default: 0, null: false
    t.integer "equipment", default: 0, null: false
    t.index ["creator_id"], name: "index_planets_on_creator_id"
    t.index ["owner_id"], name: "index_planets_on_owner_id"
    t.index ["planet_type_id"], name: "index_planets_on_planet_type_id"
    t.index ["sector_id"], name: "index_planets_on_sector_id"
  end

  create_table "players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "username"
    t.boolean "online", default: false
    t.integer "current_sector", unsigned: true
    t.integer "credits", default: 0, unsigned: true
    t.integer "turns", default: 0, unsigned: true
    t.integer "exp", default: 0, unsigned: true
    t.string "ship_name"
    t.string "email"
    t.string "password_digest"
    t.integer "alignment"
    t.integer "corporation_id", unsigned: true
    t.index ["corporation_id"], name: "index_players_on_corporation_id"
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
    t.integer "ore_qty", default: 0
    t.integer "equipment_qty", default: 0
    t.integer "organics_qty", default: 0
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
    t.integer "nav_hazard", default: 0, null: false
    t.index ["id"], name: "index_sectors_on_id"
  end

  create_table "ship_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4" do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "max_holds", unsigned: true
    t.integer "cost", unsigned: true
    t.integer "turns_per_warp", unsigned: true
    t.integer "base_holds", unsigned: true
    t.integer "max_fighters", unsigned: true
    t.integer "max_fighters_per_attack", unsigned: true
    t.boolean "long_range_scan", default: false
    t.integer "min_holds", default: 0, unsigned: true
    t.integer "max_shields", default: 0, unsigned: true
    t.integer "basic_hold_cost", unsigned: true
    t.integer "main_drive_cost", unsigned: true
    t.integer "computer_cost", unsigned: true
    t.integer "ship_hull_cost", unsigned: true
    t.integer "ship_base_cost", unsigned: true
    t.integer "offensive_odds", unsigned: true
    t.integer "defensive_odds", unsigned: true
    t.integer "mine_max"
    t.integer "genesis_max"
    t.integer "beacon_max"
    t.boolean "long_range_scanner", default: false
    t.boolean "planet_scanner", default: false
    t.boolean "transwarp_drive", default: false
    t.boolean "photon_missiles", default: false
    t.integer "max_transporter_range", default: 0
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
    t.integer "additional_holds", default: 0, unsigned: true
    t.integer "fighters", default: 0, unsigned: true
    t.integer "shields", default: 0, unsigned: true
    t.boolean "primary", default: false
    t.integer "ore_holds", default: 0, null: false
    t.integer "organics_holds", default: 0, null: false
    t.integer "equipment_holds", default: 0, null: false
    t.integer "colonist_holds", default: 0, null: false
    t.integer "genesis_torpedoes", default: 0, unsigned: true
    t.integer "ether_probes", default: 0, unsigned: true
    t.integer "limpet_mines", default: 0, unsigned: true
    t.integer "armid_mines", default: 0, unsigned: true
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
