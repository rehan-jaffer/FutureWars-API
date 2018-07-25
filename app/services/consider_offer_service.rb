class ConsiderOfferService
  prepend SimpleCommand

  def initialize(player, transaction_id, amount)
    @transaction = Transaction.where(uid: transaction_id).first
    @player = player
    @amount = amount.to_i
    @strategy = Rails.configuration.trading_strategy
    @offer_data = {
                     amount: @amount, 
                     port_id: @transaction.port_id, 
                     initial_offer: @transaction.initial_offer,
                     commodity: @transaction.commodity.to_sym,
                     qty: @transaction.qty
                  }
  end

  def validates?
    errors.add(:errors, "Transaction doesn't exist") unless @transaction
    errors.add(:errors, "This isn't your transaction") unless @transaction && @transaction.player_id == @player.id
    errors.add(:errors, 'This transaction has been closed') unless @transaction && @transaction.status == 'open'
    errors.empty?
  end

  def call

    return nil unless validates?

    unless @strategy.will_negotiate?(@offer_data)
      @transaction.status = 'rejected'
      @transaction.save
      errors.add(:errors, 'Transaction terminated.')
      return nil
    end

    if @strategy.will_accept?(@offer_data)
      @transaction.status = 'accepted'
      @transaction.save
      return { transaction: @transaction }
    end

    { offer: Offer.create(transaction_id: @transaction.id, amount: @strategy.counter_offer(@offer_data)) }
  end
end
