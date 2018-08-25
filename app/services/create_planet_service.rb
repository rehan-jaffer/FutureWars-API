require './lib/planet_namer'

class CreatePlanetService
  prepend SimpleCommand

  def initialize(sector_id, props = {})
    @sector_id = sector_id
    @props = props
  end

  def validates?
    errors.add(:errors, "Sector doesn't exist") unless Sector.exists?(@sector_id)
  end

  def random_planet_type
    PlanetType.all.map(&:id).sample
  end

  def call
    Planet.create(planet_type_id: random_planet_type, name: PlanetNamer.generate_one, sector_id: @sector_id)
  end
end
