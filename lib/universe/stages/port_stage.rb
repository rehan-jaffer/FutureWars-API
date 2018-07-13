require './lib/port_trade'

class PortStage
  def initialize; end

  def set_size(size)
    @size = size
  end

  def exec

    # These are the distributions of the various port types in the original game

    port_dist = { 1 => 0.1999, 2 => 0.1991, 3 => 0.1999, 4 => 0.0997, 5 => 0.0997, 6 => 0.0997, 7 => 0.0496, 8 => 0.0522 }

    sector_list = Sector.pluck(:id)

    predefined_ports = YAML.load(File.read("./maps/sector.yml"))["Ports"].to_a

    ports = 0.upto(@size).map do |_i|
      port_dist.max_by { |_, weight| rand**(1.0 / weight) }.first
    end

    ports.each do |port|

      unless predefined_ports.empty?
        sector_props = predefined_ports.pop[1]
      else
        sector_props = { port_class: port, 
                       sector_id: sector_list.delete_at(sector_list.length * rand) }
      end
 
      PortCreatorService.call(sector_props)
    end
    pp Sector.all
    pp Port.all
  end
end
