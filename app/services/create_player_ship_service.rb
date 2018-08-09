require './lib/generators/id_generator'

class CreatePlayerShipService
  prepend SimpleCommand

  def initialize(player, ship_name)
    @player = player
    @ship_name = ship_name
  end

  def call
    serial = IDGenerator.generate_serial

    ship = Ship.create(ship_type_id: ShipType.find_by(name: 'Merchant Cruiser'),
                       name: @ship_name,
                       serial: serial,
                       banner: serial,
                       total_holds: ShipType.find_by(name: 'Merchant Cruiser').base_holds,
                       empty_holds: ShipType.find_by(name: 'Merchant Cruiser').base_holds,
                       player_id: @player.id)

    return ship if ship.errors.empty?
    ship.errors.full_messages.map { |msg| errors.add(:errors, msg) }
    nil
  end
end
