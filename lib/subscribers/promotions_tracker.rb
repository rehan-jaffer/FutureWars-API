require './app/models/player'
require './lib/rankings'

class PromotionsTracker
  def call(event)
    exp_gain = event.data[:exp]
    player = Player.find(event.data[:player_id])
    if Rankings.rank(player.exp - 2) != Rankings.rank(player.exp)
      event_store.publish(PlayerPromoted.new(data: {player_id: player.id, new_rank: Rankings.rank(player.exp)}), stream_name: "player-#{player.id}")
    end
  end

  private

   def event_store
     Rails.configuration.event_store
   end

end
