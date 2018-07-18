require './lib/events/event_store'

class CreatePlayerService
  prepend SimpleCommand

  def initialize(username, password, ship_name)
    @username = username
    @ship_name = ship_name
    @password = password
    @streams = ["universe", "players"]
  end

  def update_events
    event = Event.new("player_created", {player_id: @player.id})
    @streams.push("player-#{@player.id}")
    EventStore.publish(event, @streams)
  end

  def call
    @player = Player.create(username: @username,
                           ship_name: @ship_name,
                           ship_type_id: ShipType.find_by(name: 'Merchant Cruiser').id,
                           alignment: 0,
                           holds: Rails.configuration.game['initial_holds'],
                           turns: Rails.configuration.game['initial_turns'],
                           current_sector: Rails.configuration.game['initial_sector'],
                           fighters: Rails.configuration.game['initial_fighters'],
                           credits: Rails.configuration.game['initial_credits'],
                           password: @password)

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
