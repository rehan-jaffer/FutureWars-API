class Player < ApplicationRecord
  has_secure_password

  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/

  def can_move?(origin, dest)
    return false unless turns > 0

    return false unless Sector.is_connected?(origin, dest)

    return false unless current_sector == origin

    true
  end
end
