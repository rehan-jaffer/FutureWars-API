# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Federation Space (zones 1-10)
ShipType.delete_all
PlanetType.delete_all
#ShipType.create(name: "Merchant Freighter", turns_per_warp: 2, max_shields: 500, max_holds: 65, initial_holds: 30, maximum_fighters: 300)
#ShipType.create(name: "Merchant Cruiser",turns_per_warp: 3, max_shields: 400, maximum_fighters: 2500, max_holds: 75, initial_holds: 20)
#ShipType.create(name: "Cargo Tran", turns_per_warp: 4, max_shields: 1000, max_holds: 125, initial_holds: 50, maximum_fighters: 400)
ShipType.create(
    name: "Merchant Cruiser", turns_per_warp: 3, base_holds: 20, 
    min_holds: 20, max_fighters: 2500, max_shields: 400, max_holds: 75, 
    max_fighters_per_attack: 750, max_fighters: 2500,
    basic_hold_cost: 10000, main_drive_cost: 1000, computer_cost: 20300,
    ship_hull_cost: 10000, ship_base_cost: 41300,
    mine_max: 50, genesis_max: 5, transwarp_drive: false, max_transporter_range: 5,
    offensive_odds: 10, beacon_max: 50, long_range_scanner: true, planet_scanner: true,
    photon_missiles: false, description: "The Merchant Cruiser is the standard fare for earning a living in the universe. These craft are moderately fast, well armored and have hard points for many different accessories. Many cartels use the Merchant Cruiser as their only ship type. The Merchant is the craft by which combat specs are rated for a standard."
  )
ShipType.create(
    name: "Scout Marauder", turns_per_warp: 2, base_holds: 10, 
    min_holds: 10, max_fighters: 250, max_shields: 100, 
    max_holds: 25, max_fighters_per_attack: 250, max_fighters: 250,
    basic_hold_cost: 5000, main_drive_cost: 3000, computer_cost: 5200,
    ship_hull_cost: 2750, ship_base_cost: 15950,
    mine_max: 0, genesis_max: 0, transwarp_drive: false, max_transporter_range: 0, 
    offensive_odds: 20, beacon_max: 10, long_range_scan: true, planet_scanner: true,
    photon_missiles: false, description: "The Scout Marauder is currently the fastest, conventional drive ship known to mankind. This small speedster can easily outdistance even the powerful Corellian Battleships. It is not equipped for controlling many fighters or shields, but it fights at 2 to 1 odds due to its quickness and small size. This craft cannot carry mines or Genesis Torpedoes. It may be small, but this ship's speed and range make up for much."
  )
ShipType.create(
    name: "Merchant Freighter", turns_per_warp: 2, base_holds: 30, 
    min_holds: 30, max_fighters: 300, max_shields: 500, 
    max_holds: 65, max_fighters_per_attack: 100, max_fighters: 300,
    basic_hold_cost: 15000, main_drive_cost: 2000, computer_cost: 9600,
    ship_hull_cost: 6800, ship_base_cost: 33400,
    mine_max: 0, genesis_max: 0, transwarp_drive: false, max_transporter_range: 0,
    offensive_odds: 20, beacon_max: 10, long_range_scan: true, planet_scanner: true,
    photon_missiles: false, description: "The Merchant Freighter is the ideal ship for those traders that do not want to concern themselves with political matters. It is not a very powerful ship in combat, but its strengths are many. This ship can carry a large number of shields and manages to outdistance most ships. After all, 'Those who fight and run away, live to fight another day' still holds very true in the universe as we know it today."
  )
ShipType.create(
    name: "Corporate Flagship", turns_per_warp: 3, base_holds: 20, 
    min_holds: 20, max_fighters: 20000, max_shields: 1500, 
    max_holds: 85, max_fighters_per_attack: 6000, 
    max_fighters: 20000, mine_max: 100, genesis_max: 10, transwarp_drive: true,
    max_transporter_range: 10, offensive_odds: 12, beacon_max: 100, long_range_scan: true,
    planet_scanner: true, photon_missiles: false, description: "Few words can actually describe the sheer awe associated with a Corporate Flagship. Only available to Corp CEOs, this huge craft is the ultimate in power and capability. Not only can it carry up to 20,000 fighters at one time, this ship carries a powerful combination of options that will make any foe turn tail and run. The most impressive capability of the Flagship is the TransWarp Drive. This device enables the ship to TransWarp to any other sector in the Universe provided one of your fighters is already there emitting a locator beam. Without this, a ship can disappear into TransWarp and never be seen again."
  )
ShipType.create(
    name: "CargoTran", turns_per_warp: 4, base_holds: 50,
    min_holds: 50, max_fighters: 400, max_shields: 1000,
    max_holds: 125, max_fighters_per_attack: 125,
    basic_hold_cost: 27000, main_drive_cost: 1000, computer_cost: 11050,
    ship_hull_cost: 12900, ship_base_cost: 51950,
    mine_max: 1, genesis_max: 2, transwarp_drive: false, offensive_odds: 8,
    beacon_max: 20, long_range_scanner: true, planet_scanner: true,
    photon_missiles: false, description: "The CargoTran is a large ship indeed. Though not as fast as some of its related trading cousins, this ship can move vast amounts of goods. It is typically a pacifist's ship as it does not carry much in the way of offensive capabilities but it's very large array of holds makes up for all of that. The large shield capacity of this craft makes it safe to wander hostile territory as well. This ship is considered by many to be one of the top money-makers in the Universe."
  )
ShipType.create(
    name: "Corellian Battleship", turns_per_warp: 4, base_holds: 16,
    min_holds: 16, max_fighters: 10000, max_shields: 750,
    max_holds: 80, max_fighters_per_attack: 3000,
    basic_hold_cost: 8000, main_drive_cost: 1000, computer_cost: 61500,
    ship_hull_cost: 18000, ship_base_cost: 88500
  )
ShipType.create(name: "Colonial Transport", 
   turns_per_warp: 6,
   basic_hold_cost: 27000, main_drive_cost: 1000, computer_cost: 10400, ship_hull_cost: 25200,
   ship_base_cost: 63600, min_holds: 50, max_fighters: 200, mine_max: 0, genesis_max: 5, transwarp_drive: false,
   max_fighters_per_attack: 100, max_transporter_range: 7, max_holds: 250, max_shields: 500,
   offensive_odds: 60, beacon_max: 10, long_range_scan: false, planet_scanner: true, photon_missiles: false)

ShipType.create(name: "Missile Frigate", turns_per_warp: 3)
ShipType.create(name: "Imperial Starship", turns_per_warp: 4)
ShipType.create(name: "Havoc GunStar", turns_per_warp: 3)
ShipType.create(name: "StarMaster", turns_per_warp: 3)
ShipType.create(name: "Constellation", turns_per_warp: 3)
ShipType.create(name: "T'Khasi Orion", turns_per_warp: 2)
ShipType.create(name: "Tholian Sentinel", turns_per_warp: 4)
ShipType.create(name: "Taurean Mule", turns_per_warp: 4)
ShipType.create(name: "Interdictor Cruiser", turns_per_warp: 15)

PlanetType.create(
    name: "Earth type", classification: "M",
    description: "Thick Oxygen/Nitrogen atmosphere. Specific gravity within 0.7 to 1.3 Earth normal. Random, but mostly manageable weather patterns, with temperatures ranging from 0 to 40 degrees Celsius. Fertile soil, excellent for Organic production. Mineral deposits, very good for Equipment production. Chemical elements good for Fuel Ore. Class M planets are excellent for human colonization and promote an excellent population growth curve as well as a very good population harmony quotient. They have an above average 'habitability band'. Drawbacks include overpopulation problems, political unrest, and human-induced destruction of the biosphere.",
    colonists_ore_ratio: 3, colonists_organics_ratio: 7, colonists_equipment_ratio: 13, 
    colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, max_colonists_organics: 30000, 
    max_colonists_equipment: 30000, max_product_ore: 100000, max_product_organics: 100000, max_product_equipment: 100000
  )
PlanetType.create(
    name: "Desert Wasteland", classification: "K", 
    description: "Thin Oxygen/Nitrogen atmosphere. Specific gravity within 0.5 to 1.5 Earth normal. Weather patterns are mostly dry and hot with temps ranging from 40 to 140 degrees Celsius. Little area of fertile soil, very bad for Organics. Very little precious metal making it bad for Equipment production. Common chemical traces making it great for Fuel Ore. Class K worlds are average for humanoid colonization but an arid and hot climate requires specialized colonists. Narrow habitability band but a generally stable political environment as the population must depend on each other to survive. Higher fatality rate than Class M worlds.",
    colonists_ore_ratio: 3, colonists_organics_ratio: 7, colonists_equipment_ratio: 13, 
    colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, max_colonists_organics: 30000, 
    max_colonists_equipment: 30000, max_product_ore: 100000, max_product_organics: 100000, max_product_equipment: 100000
  )
PlanetType.create(
    name: "Oceanic", classification: "O", 
    description: "Dense Oxygen/Nitrogen atmosphere. Specific gravity within 1.1 to 1.8 Earth normal. Random and occasional violent weather current patterns, with temps ranging from 20 to 50 degrees Celsius. No land mass to speak of, making mining for Ore more difficult. Organics production quite good (one of the best), but a poor environment for building Equipment. Class O planets are more challenging to habitate, but are almost as safe as class M. Good population growth curve and decent population harmony. Their entire surface is habitable with proper gear with the only drawbacks being the costs to settle and build citadels.",
    colonists_ore_ratio: 3, colonists_organics_ratio: 7, colonists_equipment_ratio: 13, 
    colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, max_colonists_organics: 30000, 
    max_colonists_equipment: 30000, max_product_ore: 100000, max_product_organics: 100000, max_product_equipment: 100000
  )
PlanetType.create(
    name: "Mountainous", classification: "L", 
    description: "Thin Oxygen/Nitrogen atmosphere. Specific gravity between 1.0 to 2.2 Earth normal. Weather patterns are wet with temperatures ranging anywhere from -30 to 50 degrees Celsius depending on the width of the habitability band. Excellent Mineral and Ore deposits but harsh conditions only permit avg to below avg Equipment production. Soil is excellent, providing higher than normal organics production. Colonist specialization is necessary to maintain population. Good - very good population harmony quotient. Above average 'habitability band' but only medium population growth. Drawbacks include hazards to equipment and occasional severe weather conditions.",
    colonists_ore_ratio: 3, colonists_organics_ratio: 7, colonists_equipment_ratio: 13, 
    colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, max_colonists_organics: 30000, 
    max_colonists_equipment: 30000, max_product_ore: 100000, max_product_organics: 100000, max_product_equipment: 100000
  )
PlanetType.create(
    name: "Glacial", classification: "C", colonists_ore_ratio: 3, colonists_organics_ratio: 7, 
    description: "Extremely thin Oxygen-Nitrogen atmosphere. Specific gravity from 0.5 to 1.7 Earth normal. Meteorologically unstable causing violent conditions. Temps range from -10 to -190 degrees Censius. Full life support necessary for colonies and death rates are high. No workable soil base so hydroponic Organics are limited. Modest mineral and chemicals exist so production of Ore and Equipment will be below average to none. Class C planets NOT recommended for colonization, their violent conditions makes it extremely hazardous. Some class C planets have been adopted by the Federation and used as prison colonies and used with very effective results.",
    colonists_equipment_ratio: 13, colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, 
    max_colonists_organics: 30000, max_colonists_equipment: 30000, 
    max_product_ore: 100000, max_product_organics: 100000, max_product_equipment: 100000
  )
PlanetType.create(
    name: "Volcanic", classification: "H", 
    description: "Extremely thin Oxygen / Nitrogen atmospheres. Specific gravities are within 0.8 to 2.6 Earth normal. Climate patterns are violent with temperatures from 45 to 400 degrees Celsius. Full life support required for colonization. Zero workable soil and harsh conditions make Organics production impossible. Good trace elements for equip but conditions make production a gamble at best. Excellent Ore production possibilities as material is often ejected by volcanic activity and found on the surface. Very dangerous for colony growth as unstable planetary crusts often lead to the complete loss of a colony. The Federation has been known to use Class H planets for defense of key sectors due to their large Ore base.",
    colonists_ore_ratio: 3, colonists_organics_ratio: 7, colonists_equipment_ratio: 13, 
    colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, max_colonists_organics: 30000, 
    max_colonists_equipment: 30000, max_product_ore: 100000, max_product_organics: 100000, 
    max_product_equipment: 100000
  )
PlanetType.create(
    name: "Gaseous", classification: "U", 
    description: "Heavy ranging to very thin atmospheres consisting of various elements, mostly comprised of helium or of hydrogen. Specific gravities can range from 0.2 to 8.0 of Earth normal. Climate patterns usually extremely violent with temps ranging from -200 to 400 degrees Celsius. Full life support required at all times. No production can sustain itself on a class U planet. Some miners have hinted at very valuable products that they have extracted from class U worlds but the Federation does not have them in its 'Official Guide to Mining'. Class U planets are not recommended for colonization as the environment is harsher than being in space itself.",
    colonists_ore_ratio: 3, colonists_organics_ratio: 7, colonists_equipment_ratio: 13, 
    colonists_fighters_ratio: 10, max_colonists_fuel_ore: 30000, max_colonists_organics: 30000, 
    max_colonists_equipment: 30000, max_product_ore: 100000, max_product_organics: 100000, 
    max_product_equipment: 100000
  )
