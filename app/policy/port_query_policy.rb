class PortQueryPolicy
  include PolicyObject

  def initialize(player, port)
    @port = port
    @player = player
  end

  private

  def conditions
    [
      ['You are not in that sector! Cannot query port across sectors.', @port.sector_id == @player.current_sector]
    ]
  end
end
