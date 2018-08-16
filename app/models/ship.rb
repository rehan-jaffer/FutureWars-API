class Ship < ApplicationRecord
  belongs_to :player
  has_many :holds
  belongs_to :ship_type

  def info
    "#{ship_type.name} - Ported=40 Kills=0 Distance=#{player.distance}"
  end


  def fighter_capacity
    ship_type.max_fighters - fighters
  end

  def shield_capacity
    ship_type.max_shields - shields
  end

  def total_holds
    ship_type.base_holds + additional_holds
  end

  def empty_holds
    total_holds - holds_in_use
  end

  def hold_contents
    holds.each_with_object(Hash.new(0)) { |hold, h| h[hold.contents] += hold.qty }
  end

  def have_quantity?(commodity, qty)
    hold_contents[commodity.to_s].to_i >= qty
  end

  def load_hold(commodity, qty)

    return false unless valid_commodity?(commodity)
    return false unless total_holds > 0 && empty_holds > 0

    have_quantity?(commodity, 1) ? increase_qty(commodity, qty) : create_qty(commodity, qty)

    reload
  end

  def jettison(commodity, qty)
    return false unless valid_commodity?(commodity)
    return false unless have_quantity?(commodity, qty)

    decrease_qty(commodity, qty)
  end

  private

  def increase_qty(commodity, qty)
    holds.where(contents: commodity).first.increment!(:qty, qty)
  end

  def decrease_qty(commodity, qty)
    holds.where(contents: commodity).first.decrement!(:qty, qty)
  end

  def create_qty(commodity, qty)
    Hold.create(contents: commodity, qty: qty, ship_id: id)
  end

  def holds_in_use
    holds.map(&:qty).inject(:+).to_i
  end

  def valid_commodity?(commodity)
    commodities.include?(commodity)
  end

  def commodities
    %i[equipment ore organics colonists]
  end
end
