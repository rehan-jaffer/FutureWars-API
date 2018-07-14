require './lib/generators/id_generator'

class Transaction < ApplicationRecord
  belongs_to :player
  belongs_to :port
  before_create :set_uid

  def set_uid
    self.uid = IDGenerator.generate_serial
  end

  def as_json(opts={})
    {uid: uid, status: status, age: ((Time.now() - created_at)/60.0).round}
  end

end
