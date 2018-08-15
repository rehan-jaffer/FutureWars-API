class PathFinderService
  prepend SimpleCommand

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
  end

  def validates?
    errors.add(:errors, "Destination does not exist!") unless Sector.exists?(@dest)
    errors.empty?
  end

  def call
    return nil unless validates?
    path = Warp.path(@player.current_sector, @dest)
    if path.empty?
      errors.add(:errors, "No path exists between these sectors")
      return nil
    end
    {path: path, nodes: path.size, cost: @player.move_cost(path.size), can_warp: @player.can_express_warp?(@dest)}
  end

end
