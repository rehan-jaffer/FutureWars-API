require './lib/player/turns'
require './lib/player/messaging'

class Player < ApplicationRecord

  include PlayerUnit::Turns
  include PlayerUnit::Messaging

  has_secure_password

  has_many :ships, class_name: "Ship"
  belongs_to :corporation, optional: true

#  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/, uniqueness: true, presence: true
  validates :current_sector, presence: true
  validates :alignment, presence: true
  validates :email, presence: true
  
  has_many :sent_messages, class_name: "Message", foreign_key: "from_id"
  has_many :received_messages, class_name: "Message", foreign_key: "to_id"

  def ceo?
    Corporation.with_ceo(id).count > 0
  end

  def primary_ship
    ships.where(primary: true).first
  end

  def in_a_corporation?
    !corporation.nil?
  end

  def in_corporation?(id)
    corporation_id == id
  end

  def update_sector(sector_id)
    update_attribute(:current_sector, sector_id)
  end

  def has_events?
    false
  end

  def can_express_warp?(dest)
    move_cost( Warp.hops(current_sector, dest) ) < turns
  end

  def rank
    @player_rank ||= PlayerRank.new(exp, alignment.to_i).to_s
  end

  def can_trade_at_port?(_sector_id)
    # until implemented, players can trade at all ports
    true
  end

  def new_messages?
    received_messages.unread.count > 0
  end

  def increase_credits(n)
    update_attribute(:credits, credits + n)
  end

  def decrease_credits(n)
    update_attribute(:credits, credits - n)
  end

  #  def ship
  #    @ship ||= Ship.new
  #  end
end
