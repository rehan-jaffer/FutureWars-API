
require './lib/mixins/policy_object'

class QueryClassZeroItemsPolicy

  include PolicyObject

  def initialize(player, port)
   @player = player
   @port = port
  end

  def conditions
    [
      ['You are not in the same sector as this port', @player.current_sector == @port.sector_id],
      ['Not a Class 0 Port', @port.port_class.zero?]
    ]
  end
end