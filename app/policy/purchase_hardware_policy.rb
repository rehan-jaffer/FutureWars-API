require './lib/mixins/policy_object'

class PurchaseHardwarePolicy

  include PolicyObject

  def initialize(player, item, items)
    @player = player
    @items = items
    @item = item
  end

  private

    def conditions
      [
        ['Hardware item not found', @items.include?(item)],
        ['Your ship does not support that item', @player.primary_ship.can_equip?(item)],
        ['You already have that item', @player.primary_ship.has_hardware?(item)],
      ]
    end

end
