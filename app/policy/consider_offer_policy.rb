class ConsiderOfferPolicy
  def initialize(current_user, transaction)
    @current_user = current_user
    @transaction = transaction
  end

  def allowed?
    conditions.all? { |c| c[1] }
  end

  def error
    conditions.find { |c| !c[1] }[0]
  end

  private

  def conditions
    [
      ['No such transaction', @transaction.present?],
      ["This isn't your transaction", @current_user.id == @transaction.player_id],
      ['This transaction is closed', @transaction.open?]
    ]
  end
end
