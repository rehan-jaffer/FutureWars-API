require 'port_trade'
require 'views/sector_view'
require 'views/player_view'
require 'views/port_view'
require 'views/beacon_view'
require 'port'

class Sector < ApplicationRecord
  belongs_to :planet_type, optional: true

  attr_reader :port

  def port
    @port ||= Port.new(attributes)
  end

  def has_planet?
    planet_type_id != nil
  end

  def has_port?
    port_class != nil
  end

  def view
    SectorView.render(attributes)
  end

  def players
    Player.where(current_sector: id).all
  end

  def self.warps(id)
    Warp.where(origin_id: id)
        .or(Warp.where(dest_id: id))
        .map { |el| [el[:origin_id], el[:dest_id]] }
        .flatten
        .uniq
        .reject { |x| x == id }
  end

  def self.connect(orig, dest)
    Warp.create!(origin_id: orig, dest_id: dest)
  end

  def self.connected?(origin, dest)
    (Warp.where(origin_id: origin, dest_id: dest)
        .or(Warp.where(origin_id: dest, dest_id: origin))).count > 0
  end

  def self.spawn(with_planet = true)
    if with_planet
      Sector.create(planet_type_id: 0, planet_name: PlanetNamer.generate_one, ore: 0, equipment: 0, organics: 0, colonists: 0, fighters: 0)
    else
      Sector.create(ore: 0, equipment: 0, organics: 0, colonists: 0, fighters: 0)
    end
  end

  def self.create_warps(id, id_list, _max_warps = 5, warp_function)
    warp_function.call(0).times { |_| connect(id, id_list[rand * id_list.size]) }
  end
end
