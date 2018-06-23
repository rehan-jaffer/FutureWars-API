namespace :universe do
  task create: :environment do
    0.upto(1000) do |_i|
      has_planet = true
      # initial_state = { ore: MAX_ORE * rand(), equipment: MAX_EQUIPMENT * rand(), organics: MAX_ORGANICS * rand(), colonists: MAX_COLONISTS * rand() }
      if has_planet
        Sector.create(planet_type_id: 0,
                      ore: 0, organics: 0,
                      equipment: 0, colonists: 0, planet_name: 'lollerfest')
      else
        Sector.create
      end
      # add_neighbours(i)
    end
  end
end
