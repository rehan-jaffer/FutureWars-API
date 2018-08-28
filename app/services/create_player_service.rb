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

  def call
    policy = CreatePlayerPolicy.new(@username, @password, @ship_name)

    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end

    @player = Player.create({ username: @username,
                              ship_name: @ship_name,
                              alignment: 0,
                              turns: Rails.configuration.game['initial_turns'],
                              current_sector: Rails.configuration.game['initial_sector'],
                              credits: Rails.configuration.game['initial_credits'],
                              password: @password }.merge(@props))

    ship = CreatePlayerShipService.call(@player, @ship_name)

    if @player.errors.empty?
      stream_add("player-#{@player.id}")
      emit :player_created, player_id: @player_id
      return @player
   end

    errors.add(:errors, "Couldn't save")
    @player.errors.full_messages.each { |error| errors.add(:errors, error) }
    nil
  end
end
