require './lib/mixins/policy_object'

class ConsiderOfferPolicy

  include PolicyObject

  def initialize(current_user, transaction)
    @current_user = current_user
    @transaction = transaction
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
