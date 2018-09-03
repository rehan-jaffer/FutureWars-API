class Offer < ApplicationRecord
  before_create :set_uid
  has_one :owner, foreign_key: 'transaction_id', class_name: 'Transaction', inverse_of: 'transaction', dependent: :nullify

  scope :trader, -> { where(actor_type: "player") }
  scope :tradee, -> { where(actor_type: "port") }

  validates :actor_type, inclusion: %w[player port]

  def set_uid
    self.uid = IDGenerator.generate_serial
  end

  def as_json(_opts = {})
    { id: uid, amount: amount }
  end

end
