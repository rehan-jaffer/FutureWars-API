class Offer < ApplicationRecord
  before_create :set_uid
  has_one :owner, foreign_key: 'transaction_id', class_name: 'Transaction', inverse_of: 'transaction', dependent: :nullify

  def set_uid
    self.uid = IDGenerator.generate_serial
  end

  def as_json(_opts = {})
    { id: uid, amount: amount }
  end

  def final?
    final
  end
end
