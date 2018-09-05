require './lib/mixins/policy_object'

class LaunchEtherProbePolicy

  include PolicyObject

  def initialize(player, dest)
    @player = player
    @dest = dest
  end

  private

    def conditions
      [
        ['Player does not exist', @player],
        ['You do not have any ether probes', @player.primary_ship.has_equip?(:ether_probes, 1)]
      ]
    end

end
