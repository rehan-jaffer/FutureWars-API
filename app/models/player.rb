class Player < ApplicationRecord
  has_secure_password

  has_one :ship_type

  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/

  def view
    {
      username: username,
      turns: turns,
      credits: credits,
      current_sector: current_sector,
      fighters: fighters,
      colonists: colonists,
      ore: ore,
      equipment: equipment,
      organics: organics
    }
  end

  def move!(origin, destination)
    MovePlayer.call(id, origin, destination).success?
  end
end
