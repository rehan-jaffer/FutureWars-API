class TransactionPolicy
  def initialize(current_user, transaction)
    @current_user = current_user
    @transaction = transaction
  end

  def can_resume_transaction?
    @transaction && @transaction.player_id && @transaction.open?
  end
end
