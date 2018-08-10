require './lib/pricing/class_zero_items'

class QueryClassZeroItemsService
  prepend SimpleCommand

  def initialize(current_user_id, port_id)
    @player = Player.find(current_user_id)
    @port = Port.find(port_id)
  end

  def validates?
    errors.add(:errors, 'You are not in the same sector as this port') unless @player.current_sector == @port.sector_id
    errors.add(:errors, 'Not a Class 0 Port') unless @port.port_class.zero?
    errors.empty?
  end

  def call
    return nil unless validates?

    fighter_price = ClassZeroItems::Pricing.fighter_price
    shield_price = ClassZeroItems::Pricing.shield_price

    fighter_count = [
      @player.credits / fighter_price,
      ship_type.max_fighters
    ].min

    shield_count = [
      @player.credits / shield_price,
      ship_type.max_shields
    ].min

    hold_count = ship.available_holds
                     .upto(ship_type.max_holds)
                     .map { |holds| Holds.price(holds) }
                     .find_index { |cost| cost >= @player.credits }

    { "items": [
      {
        item: 'fighters',
        cost: fighter_price,
        available: fighter_count
      },
      {
        item: 'shields',
        cost: shield_price,
        available: shield_count
      },
      {
        item: 'holds',
        cost: Holds.price(ship.available_holds),
        available: hold_count
      }
    ] }
  end

  private

  def ship
    @player.primary_ship
  end

  def ship_type
    @player.primary_ship.ship_type
  end
end
