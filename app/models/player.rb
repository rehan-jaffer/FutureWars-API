require './lib/player/turns'
require './lib/player/messaging'

class Player < ApplicationRecord

  include PlayerUnit::Turns
  include PlayerUnit::Messaging

  has_secure_password

  has_one :ship
  belongs_to :corporation

  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/, uniqueness: true, presence: true
  validates :current_sector, presence: true
  validates :alignment, presence: true
  validates :email, presence: true
  
  has_many :sent_messages, class_name: "Message", foreign_key: "from_id"
  has_many :received_messages, class_name: "Message", foreign_key: "to_id"

  belongs_to :ship_type

  def ceo?
    Corporation.where(ceo_id: id).count > 0
  end

  def in_corporation?
    !corporation.nil?
  end

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

  def new_messages?
    received_messages.unread.count > 0
  end

  delegate :name, to: :ship_type, prefix: true
  delegate :turns_per_warp, to: :ship_type, prefix: true

  #  def ship
  #    @ship ||= Ship.new
  #  end
end
