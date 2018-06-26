class Sector < ApplicationRecord
  def self.warps(id)
    Warp.where(origin_id: id).or(Warp.where(dest_id: id)).map { |el| [el[:origin_id], el[:dest_id]] }.flatten.uniq.reject { |x| x == id }
  end

  def self.connect(orig, dest)
    Warp.create(orig_id: orig, dest_id: dest)
  end

  def self.is_connected?(origin, dest)
    Warp.where(origin_id: origin, dest_id: dest).or(Warp.where(dest_id: dest, origin_id: origin)).count > 0
  end

  def inbound
    Warp.where(dest_id: id).map(&:origin_id)
  end

  def outbound
    Warp.where(origin_id: id).map(&:dest_id)
  end

  def self.spawn(_id, with_planet = true)
    sector = if with_planet
               Sector.create(planet_type_id: 0, planet_name: PlanetNamer.generate_one, ore: 0, equipment: 0, organics: 0, colonists: 0, fighters: 0)
             else
               Sector.create(ore: 0, equipment: 0, organics: 0, colonists: 0, fighters: 0)
             end
  end

  def self.create_warps(id, id_list, _max_warps = 5, warp_function)
    warps = warp_function.call
    warps.times do |_i|
      dest_sector = id_list[rand * id_list.size]
      Warp.create(origin_id: id, dest_id: dest_sector)
    end
  end
end
