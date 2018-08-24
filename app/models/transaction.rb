require './lib/generators/id_generator'

class Transaction < ApplicationRecord
  belongs_to :player
  belongs_to :port
  has_many :offers
  before_create :set_uid

  validates :initial_offer, presence: true
  validates :trade_type, presence: true
  validates :qty, presence: true, numericality: true
  validates_associated :port

  def open?
    status == "open"
  end

  def set_uid
    self.uid = IDGenerator.generate_serial
  end

  def as_json(_opts = {})
    { uid: uid, status: status, age: age_in_minutes }
  end

  def current_offer
    offers.last
  end

  private

  def age_in_minutes
    ((Time.now - created_at) / 60.0).round
  end
end
