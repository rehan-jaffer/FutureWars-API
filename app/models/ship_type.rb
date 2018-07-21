class ShipType < ApplicationRecord
  has_many :players

  def to_s
    "#{name}"
  end

end
