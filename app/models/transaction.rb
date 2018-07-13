require './lib/generators/id_generator'

class Transaction < ApplicationRecord
  belongs_to :player
  belongs_to :port
  before_create :set_uid

  def set_uid
    self.uid = IDGenerator.generate_serial
  end
end
