require 'pp'

class PortStage
  def initialize; end

  def set_size(size)
    @size = size
  end

  def exec
    # These are the distributions of the various port types in the original game as found online
 
    port_dist = {1 => 0.1999, 2 => 0.1991, 3 => 0.1999, 4 => 0.0997, 5 => 0.0997, 6 => 0.0997, 7 => 0.0496, 8 => 0.0522}
    sector_list = Sector.pluck(:id)
    ports = []

    1000.times do |i|
      z = port_dist.max_by { |_, weight| rand ** (1.0 / weight) }.first
      ports.push(z)
    end

    ports.each do |port|
      s = sector_list.delete_at(sector_list.length * rand)
      Port.create!(port_class: port, sector_id: s, name: PlanetNamer.generate_one)
    end

  end



end
