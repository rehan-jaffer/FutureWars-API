class ExpressWarpPolicy

  include PolicyObject

  def initialize
  end

  def conditions
    [
      ['Destination does not exist', Sector.exists?(@dest)]
      ['You do not have enough turns', @player.can_express_warp?(@dest)]
    ]
  end

end
