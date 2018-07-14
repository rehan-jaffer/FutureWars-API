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

  def self.event(type, resource_id, values)
    Player.set_explored(resource_id, values[1]) if type == :player_move
  end

  def self.destroy
    Warp.destroy_all
    Sector.destroy_all
  end

end
