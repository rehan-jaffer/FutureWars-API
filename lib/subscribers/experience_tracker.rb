require './app/models/player'

module EventHook
  def publish(event_name, stream_name, data_fields)
    event = Object.const_get(translate(event_name))
    event_store.publish(event.new(data: data_fields), stream_name: stream_name)
  end

  def on(event, event_name, &block)
     yield event.data if translate(event_name) == event.type
  end

  def translate(event_name_symbol)
    event_name_symbol.to_s.split('_').map(&:capitalize).join('')
  end

  def event_store
    Rails.configuration.event_store
  end

end

class ExperienceTracker

  include EventHook

  def call(event)

    on event, :player_moved do |data|
      player = Player.find(data[:player_id])
      player.increment!(:exp, 2)
      publish :player_gained_experience, "player-#{player.id}", player_id: player.id, exp: 2
    end

  end

end
