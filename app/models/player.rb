require './lib/player/turns'
require './lib/player/messaging'
require './lib/rankings'
require './lib/events/projections'
require './lib/pricing/class_zero_items'

class Player < ApplicationRecord
  include PlayerUnit::Turns
  include PlayerUnit::Messaging

  has_secure_password

  has_many :ships, class_name: 'Ship', dependent: :destroy
  belongs_to :corporation, optional: true

  #  validates :ship_name, presence: true, format: /\A[a-zA-Z0-9 \-_]+\z/
  validates :username, format: /\A[a-zA-Z0-9 ]+\z/, uniqueness: true, presence: true
  validates :current_sector, presence: true
  validates :alignment, presence: true
  validates :email, presence: true

  has_many :sent_messages, class_name: 'Message', foreign_key: 'from_id', dependent: :nullify
  has_many :received_messages, class_name: 'Message', foreign_key: 'to_id', dependent: :nullify

  def ceo?
    Corporation.with_ceo(id).count > 0
  end

  def distance
    Projection::Player.distance(id)
  end

  def explored?(sector_id)
    Projection::Player.explored_sectors(id).include?(sector_id)
  end

  def in_a_corporation?
    !corporation.nil?
  end

  def in_corporation?(id)
    corporation_id == id
  end

  def new_messages?
    received_messages.unread.count > 0
  end

  def has_events?
    false
  end

  def can_express_warp?(dest)
    move_cost(Warp.hops(current_sector, dest)) < turns
  end

  def can_trade_at_port?(_sector_id)
    true
  end

  def explored
    @explored ||= Projection::Player.explored_sectors(id)
  end

  def primary_ship
    ships.find_by(primary: true)
  end

  def rank
    Rankings.rank(exp, alignment)
  end

  def update_sector(sector_id)
    update_attribute(:current_sector, sector_id)
  end

  def increase_credits(n)
    update_attribute(:credits, credits + n)
  end

  def decrease_credits(n)
    update_attribute(:credits, credits - n)
  end

  def feed
    event_store
      .read
      .stream("player-#{id}")
      .each.to_a
      .map do |event|
      {
        item: feed_item(event),
        timestamp: event.timestamp
      }
    end
  end

  def feed_item(event)
    case event.type
    when 'PlayerMoved'
      "#{username} warped to sector #{event.data[:dest_id]}"
    when 'PlayerGainedExperience'
      "#{username} gained #{event.data[:exp]} exp"
    when 'PlayerPromoted'
      "#{username} was promoted to #{event.data[:new_rank]}"
    when 'CorporationCreated'
      "#{username} created the corporation #{event.data[:corporation_name]}"
    else
      event.type
    end
  end

  private

  def event_store
    Rails.configuration.event_store
  end

  def ship
    primary_ship
  end

  def ship_type
    primary_ship.ship_type
  end
end
