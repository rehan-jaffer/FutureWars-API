class PathFinderService
  prepend SimpleCommand

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
  end

  def call
    path = Warp.path(@player.current_sector, @dest)
    policy = PathFinderPolicy.new(@dest, path)

    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end


    { path: path, nodes: path.size, cost: @player.move_cost(path.size), can_warp: @player.can_express_warp?(@dest) }
  end
end
