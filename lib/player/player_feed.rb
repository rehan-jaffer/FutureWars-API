class PlayerFeed

  def initialize(player)
    @player = player
  end

  def feed
    event_store
      .read
      .stream("player-#{@player.id}")
      .each.to_a
      .map do |event|
      {
        item: feed_item(event),
        timestamp: event.timestamp
      }
    end
  end

  def feed_item(event)
    case event.type
    when 'PlayerMoved'
      "#{@player.username} warped to sector #{event.data[:dest_id]}"
    when 'PlayerGainedExperience'
      "#{@player.username} gained #{event.data[:exp]} exp"
    when 'PlayerPromoted'
      "#{@player.username} was promoted to #{event.data[:new_rank]}"
    when 'CorporationCreated'
      "#{@player.username} created the corporation #{event.data[:corporation_name]}"
    else
      event.type
    end
  end

  private

    def event_store
      Rails.configuration.event_store
    end


end
