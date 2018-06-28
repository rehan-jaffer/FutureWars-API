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
      sector_properties[:port_class] = ((rand * 7) + 1).round
      sector_properties[:port_name] = PlanetNamer.generate_one
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

  def trade_setting
    [nil, 'B', 'S', 'T'][(rand * 3).round]
  end
end
