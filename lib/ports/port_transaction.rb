class PortTransaction

def initialize(port, player, transaction, amount)
  @port = port
  @player = player
  @transaction = transaction
  @amount = amount
end

def accept!
  @transaction.trade_type == "buy" ? perform_buy : perform_sell
end

  def perform_buy
    @player.primary_ship.load(@transaction.commodity, @transaction.qty)
    @player.credits -= @amount
    @port.accumulated_trading_credits += @amount
  end

  def perform_sell
    @player.primary_ship.jettison_holds(@transaction.commodity, @transaction.qty)
    @player.credits += @amount
  end

end 