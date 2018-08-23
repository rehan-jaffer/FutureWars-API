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

    { 
      "items": 
        {
          'fighters': {
          cost: @port.class_zero.fighter_price,
          available: @port.class_zero.fighter_count(@player.credits, @player.ship)
          },
          'shields': {
            cost: @port.class_zero.shield_price,
            available: @port.class_zero.shield_count(@player.credits, @player.ship)
          },
          'holds': {
            cost: @port.class_zero.hold_price,
            available: @port.class_zero.hold_count(@player.credits, @player.ship)
          }
        }
    }

  end

  private

  def ship
    @player.primary_ship
  end

  def ship_type
    @player.primary_ship.ship_type
  end
end
