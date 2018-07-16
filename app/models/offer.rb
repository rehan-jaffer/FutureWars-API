class Offer < ApplicationRecord
  before_create :set_uid

  def set_uid
    self.uid = IDGenerator.generate_serial
  end

  def as_json(_opts = {})
    { id: uid, amount: amount }
  end
end
