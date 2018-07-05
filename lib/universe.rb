class Universe
  DEFAULT_CREDITS = 10_000
  DEFAULT_TURNS = 300
  DEFAULT_FIGHTERS = 100
  DEFAULT_EXP = 0
  DEFAULT_HOLDS = 20
  DEFAULT_COLONISTS = 100

  MAX_ORE = 10_000
  MAX_EQUIPMENT = 20_000
  MAX_ORGANICS = 50_000
  MAX_COLONISTS = 1000

  PLANET_TYPES = %w[M K O L C H U].freeze

  PLANET_RATIO = 0.8

  INITIAL_SECTOR = 0

  def self.event(type, resource_id)
    # dummy function
  end

  def self.destroy
    Warp.destroy_all
    Sector.destroy_all
  end

  def self.create(size, planet_ratio = 0.6, warp_function = nil)

    yield

    port_ratio = 0.9
    warp_function ||= ->(_x) { (rand * 5).round }

    sector_list = (0..size).map { |i|
        SectorCreator.call((rand < planet_ratio), (rand < port_ratio), $SECTORS[i]).result.id if $SECTORS[i]
        SectorCreator.call((rand < planet_ratio), (rand < port_ratio)).result.id 
    }

    sector_list.each do |sector|
      Sector.create_warps(sector, sector_list, warp_function)
    end

    home_sector = Sector.first
    home_sector.home_sector = true
    home_sector.save

    Sector.first(10).each do |sector|
      sector.federation_space = true
      sector.save
    end

  end
end
