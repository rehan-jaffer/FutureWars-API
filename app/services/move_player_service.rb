class MovePlayerService
  prepend SimpleCommand

  def initialize(player_id, dest)
    @player = Player.find(player_id)
    @dest = dest
    @streams = ["universe"]
  end

  def validates?
    errors.add(:errors, 'These parts of space are not connected') unless Warp.connected?(@player.current_sector, @dest)
    errors.add(:errors, 'You have no turns left') unless @player.turns > 0
    errors.add(:errors, 'Not a valid sector ID') unless Sector.exists?(@dest)
    errors.empty?
  end

  def update_player_state
    @player.current_sector = @dest
    @player.turns -= 3
    @player.save
  end

  def update_events

    event = PlayerMoved.new(data: {
      player_id: @player.id,
      sector_id: @dest
    });

    @streams.each do |stream|
      Rails.configuration.event_store.publish(event, stream_name: stream)
    end

  end

  def call
    return nil unless validates?
    update_player_state
    update_events
    @player
  end
end
