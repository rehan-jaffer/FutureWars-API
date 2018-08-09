class Ship < ApplicationRecord

  belongs_to :player
  has_many :holds
  belongs_to :ship_type

  def available_holds
    ship_type.base_holds + additional_holds
  end

  def empty_holds
    available_holds - holds.map { |hold| hold.qty > 0 }.inject(:+).to_i
  end

end
