class Player < ApplicationRecord
  has_secure_password

  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/, uniqueness: true

  belongs_to :ship_type

  def rank
    @player_rank ||= PlayerRank.new(exp, alignment.to_i).to_s
  end

  def can_trade_at_port?(_sector_id)
    # until implemented, players can trade at all ports
    true
  end

  delegate :name, to: :ship_type, prefix: true

  def ship
    @ship ||= Ship.new
  end

end
