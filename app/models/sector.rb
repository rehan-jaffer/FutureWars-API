require 'port_trade'
require './lib/scanners/density'

class Sector < ApplicationRecord

  has_one :port, dependent: :destroy
  has_many :planets

  def self.density(id)
    sector = Sector.find(id)
    planet_count = 500 * sector.planets.size
    ship_count = 40 * sector.players_in_sector.count
    nav_haz = 21 * (sector.nav_hazard / 100)
    planet_count + ship_count + nav_haz
  end

  def density
    Density.value(self)
  end

  def anom?
    Density.anom?(self)
  end

  def self.path(origin, destination)
     ActiveRecord::Base.connection.execute("select p.id from warp_graph fg join sectors p on (fg.linkid=p.id)where fg.latch = '1' and origid = #{origin} and destid = #{destination}").to_a.flatten
  end

  def has_port?
    !port.nil?
  end

  def players_in_sector
    Player.where(current_sector: id).all
  end

  def warps
    Warp.warps_for(id)
  end

  def self.create_warps(id, id_list, _max_warps = 5, warp_function)	
    warp_function.call(0).times { |_| Warp.connect(id, id_list[rand * id_list.size]) }	
  end

  def cloaked_ships_present?
    players_in_sector.select { |player| player.primary_ship.has_equip?(:cloak) }.size > 0
  end

  def limpet_mines_present?
   false
  end

end
