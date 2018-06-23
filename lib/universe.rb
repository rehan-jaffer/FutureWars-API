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

  def add_neighbours(sector_num)
    num_neighbours = (rand * 4).round
    num_neighbours.times do |_i|
      dest = (rand * 1000).round
      Warp.create(orig_id: sector_num, dest_id: dest)
    end
  end
end
