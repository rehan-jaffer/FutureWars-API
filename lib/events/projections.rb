module Projection
  module Player

    def self.distance(id)
      RailsEventStore::Projection.from_stream("player_#{id}")
        .init( -> { { moves: 0 } })
        .when(PlayerMoved, ->(state, event) { state[:moves] += 1 })
        .run(event_store)[:moves]
    end

    def self.explored_sectors(id)
      RailsEventStore::Projection.from_stream("player_#{id}")
        .init( -> { { sectors: [] } })
        .when(PlayerMoved, ->(state, event) { state[:sectors].push(event.data[:dest_id]) })
        .run(event_store)[:sectors]
        .uniq
        .sort
    end

    def self.event_store
      Rails.configuration.event_store
    end
  end

end
