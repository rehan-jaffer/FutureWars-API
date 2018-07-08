class SectorCreatorService
  prepend SimpleCommand

  def initialize(with_planet = true, with_port = true, additional_properties = {})
    @with_planet = with_planet
    @with_port = with_port
    @additional_properties = additional_properties
  end

  def call
    sector_properties = @additional_properties.merge(has_port: false)
    #    if @with_planet
    #          sector_properties[:planet_type_id] = PlanetType.random_id
    #          sector_properties[:planet_name] = PlanetNamer.generate_one
    #    end
    if @with_port
      port_list = PortType.all.map(&:id)
      sector_properties[:has_port] = true
      sector_properties.merge!(generate_port)
    end

    Sector.find(sector_properties[:id]).destroy if sector_properties.key?(:id) && Sector.where(id: sector_properties[:id]).count > 0

    new_sector = Sector.create(sector_properties)
    if new_sector.errors.empty?
      return new_sector
    else
      errors.add(:save, new_sector.errors)
      return nil
    end
  end

  private

  def qty
    1500 + (rand * 1000) - 500
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
