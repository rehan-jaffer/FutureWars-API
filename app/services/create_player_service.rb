require './lib/events/event_emitter'

class CreatePlayerService
  prepend SimpleCommand
  include EventEmitter

  def initialize(username, password, ship_name, props = {})
    @username = username
    @ship_name = ship_name
    @password = password
    @props = props
    streams(%w[universe players])
  end

  def update_events
    stream_add("player-#{@player.id}")
    emit_event(PlayerCreated, player_id: @player_id)
  end

  def validates?
    errors.add(:errors, 'No username supplied') unless @username
    errors.add(:errors, 'No password supplied') unless @password
    errors.add(:errors, 'No ship name supplied') unless @ship_name
    errors.empty?
  end

  def call
    return nil unless validates?

    @player = Player.create({ username: @username,
                              ship_name: @ship_name,
                              alignment: 0,
                              turns: Rails.configuration.game['initial_turns'],
                              current_sector: Rails.configuration.game['initial_sector'],
                              credits: Rails.configuration.game['initial_credits'],
                              password: @password }.merge(@props))

    ship = CreatePlayerShipService.call(@player, @ship_name)

    if @player.errors.empty?
      update_events
      return @player
   end

    errors.add(:errors, "Couldn't save")
    @player.errors.full_messages.each { |error| errors.add(:errors, error) }
    nil
  end
end
