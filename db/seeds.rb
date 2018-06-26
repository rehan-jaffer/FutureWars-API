# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Federation Space (zones 1-10)
PlanetType.create(name:"Oceanic", classification: "O")
PlanetType.create(name:"Glacial", classification: "C")
PlanetType.create(name:"Volcanic", classification: "H")
PlanetType.create(name:"Mountainous", classification: "L")
PlanetType.create(name:"Earth-Type", classification: "M")
PlanetType.create(name:"Desert Wasteland", classification: "K")
PlanetType.create(name:"Gaseous", classification: "V")
ShipType.create(name: "Merchant Freighter")
ShipType.create(name: "Merchant Cruiser")
ShipType.create(name: "Cargo Train")
ShipType.create(name: "Taurean Mule")
ShipType.create(name: "Colonial Transport")
