class AssignColonistsService
  prepend SimpleCommand

  def initialize(player_id, planet_id, commodity, colonists)
    @player = Player.where(id: player_id).first
    @planet = Planet.where(id: planet_id).first
    @commodity = commodity
    @colonists = colonists
  end

  def call; end
end
