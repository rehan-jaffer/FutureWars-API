require './lib/mixins/policy_object'

class MovePlayerPolicy

  include PolicyObject

  def initialize(player, dest)
    @player = player
    @dest = dest
  end

  private

    def conditions
      [
        ['Not a valid sector ID', Sector.exists?(@dest)],
        ['These parts of space are not connected', Warp.connected?(@player.current_sector, @dest)],
        ['You have no turns left', @player.turns > 0]
      ]
    end

end
