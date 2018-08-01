class ShipType < ApplicationRecord
  has_many :players

  delegate :to_s, to: :name
end
