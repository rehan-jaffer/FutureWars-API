require './app/models/player'

class ExperienceTracker
  def call(event)
    case event.type
      when "PlayerMoved"
        pid = event.data[:player_id]
        Player.find(pid).increment!(:exp, 2)
        event_store.publish(PlayerGainedExperience.new(data: {player_id: pid, exp: 2}), stream_name: "player-#{pid}")
      else
        puts event.type
    end
  end

  private

   def event_store
     Rails.configuration.event_store
   end

end
