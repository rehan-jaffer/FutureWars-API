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

  def self.destroy
    Warp.destroy_all
    Sector.destroy_all
  end

  def self.create(size, planet_ratio = 0.6, warp_function = nil)
    warp_function ||= ->(_x) { (rand * 5).round }

    size.times { |i| Sector.spawn(i, (rand < planet_ratio)) }

    sector_list = Sector.all.map(&:id)

    sector_list.each do |sector|
      Sector.create_warps(sector, sector_list, warp_function)
    end
  end
end
