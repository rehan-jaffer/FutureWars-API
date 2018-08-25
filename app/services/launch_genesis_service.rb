class LaunchGenesisService
  def initialize(player_id, sector_id)
    @player = Player.where(id: player_id).first
    @sector = Sector.where(id: sector_id).first
  end

  def validates?; end

  def call; end
end
