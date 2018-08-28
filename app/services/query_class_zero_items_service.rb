require './lib/pricing/class_zero_items'

class QueryClassZeroItemsService
  prepend SimpleCommand

  def initialize(player, port)
    @player = player
    @port = port
  end


  def call
    policy = QueryClassZeroItemsPolicy.new(@player, @port)

    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end

    {
      "items":
        {
          'fighters': {
            cost: @port.class_zero.fighter_price,
            available: @port.class_zero.fighter_count(@player.credits, @player.primary_ship)
          },
          'shields': {
            cost: @port.class_zero.shield_price,
            available: @port.class_zero.shield_count(@player.credits, @player.primary_ship)
          },
          'holds': {
            cost: @port.class_zero.next_hold_price(@player.primary_ship.total_holds),
            available: @port.class_zero.hold_count(@player.credits, @player.primary_ship)
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
