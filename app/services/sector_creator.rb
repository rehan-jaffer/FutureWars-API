class SectorCreator
  prepend SimpleCommand

  def initialize(with_planet = true, with_port = true)
    @with_planet = with_planet
    @with_port = with_port
  end

  def call
    sector_properties = { has_port: false }
    #    if @with_planet
    #      sector_properties[:planet_type_id] = PlanetType.random_id
    #      sector_properties[:planet_name] = PlanetNamer.generate_one
    # s    end
    if @with_port
      port_list = PortType.all.map(&:id)
      sector_properties[:has_port] = true
      sector_properties.merge!(generate_port)
    end
    sector = Sector.create(sector_properties)
    puts sector.errors.full_messages
    if sector.errors.empty?
      return sector
    else
      errors.add(:save, sector.errors)
      return nil
    end
  end

  private

  def qty
    1500 + (rand() * 1000) - 500
  end

  def generate_port
    {
      port_class: ((rand * 7) + 1).round,
      port_name: PlanetNamer.generate_one,
      ore_qty: qty,
      organics_qty: qty,
      equipment_qty: qty
    }
  end

end
