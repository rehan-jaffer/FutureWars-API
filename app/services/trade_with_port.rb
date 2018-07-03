class TradeWithPort

  prepend SimpleCommand

  def initialize(sector_id, user_id, commodity, buy_or_sell, qty, price)
    @sector_id = sector_id
    @user_id = user_id
    @commodity = commodity
    @buy_or_sell = buy_or_sell
    @qty = qty
    @price = price
  end

  def call()

    sector = Sector.find(id)
    player = Player.find(id)

    success = true

    fail = !success

    if success
      sector["#{@commodity}_qty"] -= @qty
      player.credits -= (@price * @qty)
      if sector.save && player.save
        return "success"
      else
        errors.add(:trade, "fail")
      end
    end

  end

end
