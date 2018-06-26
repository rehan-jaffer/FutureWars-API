class Sector < ApplicationRecord
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

  def self.create_warps(id, id_list, max_warps = 5, _total_sectors = 1000)
    warps = (0..max_warps).to_a.sample
    warps.times do |_i|
      dest_sector = id_list[rand * id_list.size - 1]
      Warp.create(origin_id: id, dest_id: dest_sector)
    end
  end
end
