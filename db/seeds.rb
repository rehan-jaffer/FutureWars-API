# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Federation Space (zones 1-10)
ShipType.destroy_all
#ShipType.create(name: "Merchant Freighter", turns_per_warp: 2, maximum_shields: 500, maximum_holds: 65, initial_holds: 30, maximum_fighters: 300)
#ShipType.create(name: "Merchant Cruiser",turns_per_warp: 3, maximum_shields: 400, maximum_fighters: 2500, maximum_holds: 75, initial_holds: 20)
#ShipType.create(name: "Cargo Tran", turns_per_warp: 4, maximum_shields: 1000, maximum_holds: 125, initial_holds: 50, maximum_fighters: 400)
ShipType.create(name: "Merchant Cruiser")
ShipType.create(name: "Merchant Freighter")
ShipType.create(name: "CargoTran")
