class Ship < ApplicationRecord

  belongs_to :player
  has_many :holds
  belongs_to :ship_type

  def info
    "#{ship_type.name} - Ported=40 Kills=0"
  end

  def fighter_capacity
    (ship_type.max_fighters - fighters)
  end

  def shield_capacity
    (ship_type.max_shields - shields)
  end

  def available_holds
    (ship_type.base_holds + additional_holds)
  end

  def empty_holds
    available_holds - holds.map { |hold| hold.qty }.inject(:+).to_i
  end

  def hold_contents
    holds.each_with_object(Hash.new(0)) { |hold, hsh| hsh[hold.contents] += hold.qty }
  end

  def have_quantity?(commodity, qty)
    hold_contents[commodity.to_s].to_i >= qty
  end

  def load_hold(commodity, qty)
    return false unless commodities.include?(commodity)
    return false unless available_holds > 0 && empty_holds > 0

    if have_quantity?(commodity, 1)
      holds.where(contents: commodity).first.increment!(:qty, qty) if have_quantity?(commodity, 1)
    else
      Hold.create(contents: commodity, qty: qty, ship_id: id)
    end

    reload
  end
 
  def jettison(commodity, qty)
    return false unless commodities.include?(commodity)
    return false unless have_quantity?(commodity, qty)
    holds.where(contents: commodity).first.decrement!(:qty, qty)  
  end

  def commodities
    [:equipment, :ore, :organics, :colonists]
  end

end
