class ConsiderOfferService
  prepend SimpleCommand

  TARGET_PRICE = 20

  def initialize(player, transaction_id, amount)
    @transaction = Transaction.where(uid: transaction_id).first
    @player = player
    @amount = amount
  end

  def call
    errors.add(:errors, "Transaction doesn't exist") unless @transaction
    errors.add(:errors, "This isn't your transaction") unless @transaction && @transaction.player_id == @player.id
    errors.add(:errors, 'This transaction has been closed') unless @transaction && @transaction.status == 'open'

    return nil unless errors.empty?

    strategy = Rails.configuration.trading_strategy

    unless strategy.will_negotiate?(@amount)
      @transaction.status = 'rejected'
      @transaction.save
      errors.add(:errors, 'Transaction terminated.')
      return nil
    end

    if strategy.will_accept?(@amount)
      @transaction.status = 'accepted'
      @transaction.save
      return @transaction
    end

    Offer.create(transaction_id: @transaction.id, amount: strategy.counter_offer(@amount))
  end
end
