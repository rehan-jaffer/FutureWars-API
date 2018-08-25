class ClassZeroPort
  def initialize(port)
    @port = port
  end

  def fighter_price
    fighter_price = ClassZeroItems::Pricing.fighter_price
  end

  def shield_price
    shield_price = ClassZeroItems::Pricing.shield_price
  end

  def next_hold_price
    Holds.price(total_holds + 1)
  end

  def item_count(item, credits, ship)
    case item
    when :fighters
      fighter_count(credits, ship)
    when :shields
      shield_count(credits, ship)
    when :holds
      hold_count(credits, ship)
    end
  end

  def item_cost(item)
    case item
    when :fighters
      fighter_price
    when :shields
      shield_price
    when :holds
      hold_count
    end
  end

  def fighter_count(credits, ship)
    fighter_count = [
      credits / fighter_price,
      ship.ship_type.max_fighters
    ].min
  end

  def shield_count(credits, ship)
    [
      credits / shield_price,
      ship.ship_type.max_shields
    ].min
  end

  def hold_count(credits, ship)
    ship.total_holds
        .upto(ship_type.max_holds)
        .map { |holds| Holds.price(holds) }
        .find_index { |cost| cost >= credits }
  end
end
