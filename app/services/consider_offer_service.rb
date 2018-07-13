class ConsiderOfferService

  prepend SimpleCommand
  
  TARGET_PRICE = 20

  def initialize(player, transaction_id, amount)
    @transaction = Transaction.find(transaction_id)
    @player = player
    @amount = amount
  end

  def call
    errors.add(:errors, "Transaction doesn't exist") unless @transaction
    errors.add(:errors, "This isn't your transaction") unless @transaction.player_id == @player.id
    errors.add(:errors, "This transaction has been closed") unless @transaction.status == "open"

    return nil unless errors.empty?

    if @amount == TARGET_PRICE
      @transaction.status = "accepted"
      @transaction.save
      return @transaction
    elsif @amount > TARGET_PRICE
      @offer_amount = (TARGET_PRICE + (@amount-TARGET_PRICE)/2) 
      Offer.create(transaction_id: @transaction.id, amount: @offer_amount)
    elsif @amount < TARGET_PRICE
      @transaction.status = "rejected"
      @transaction.save
      errors.add(:errors, "Transaction terminated.")
      return nil
    end
  end

end
