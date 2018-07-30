require './lib/player/turns'

class Player < ApplicationRecord
  include PlayerUnit::Turns

  has_secure_password

  has_one :ship

  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/, uniqueness: true, presence: true
  validates :current_sector, presence: true
  validates :alignment, presence: true
  

  belongs_to :ship_type

  def update_sector(sector_id)
    update_attribute(:current_sector, sector_id)
  end

  def has_events?
    false
  end

  def can_express_warp?(dest)
    move_cost( Warp.path(current_sector, dest).size ) < turns
  end

  def rank
    @player_rank ||= PlayerRank.new(exp, alignment.to_i).to_s
  end

  def can_trade_at_port?(_sector_id)
    # until implemented, players can trade at all ports
    true
  end

  delegate :name, to: :ship_type, prefix: true
  delegate :turns_per_warp, to: :ship_type, prefix: true

  #  def ship
  #    @ship ||= Ship.new
  #  end
end
