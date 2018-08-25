class ShipType < ApplicationRecord

  has_many :players, dependent: :nullify
  delegate :to_s, to: :name

end
