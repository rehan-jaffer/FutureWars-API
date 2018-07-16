require './lib/port_trade'

class PortStage
  def initialize
    @ports = YAML.safe_load(File.read('./maps/sector.yml'))['Ports'].to_a
    @port_dists = { 1 => 0.1999, 2 => 0.1991, 3 => 0.1999, 4 => 0.0997, 5 => 0.0997, 6 => 0.0997, 7 => 0.0496, 8 => 0.0522 }
    @sector_list = Sector.pluck(:id)
  end

  def set_size(size)
    @size = size
  end

  def port_preset(port)
    { port_class: port, sector_id: @sector_list.delete_at(@sector_list.length * rand) }
  end

  def port_distribution
    0.upto(@size).map do |_i|
      @port_dists.max_by { |_, weight| rand**(1.0 / weight) }.first
    end
  end

  def exec
    port_distribution.each_with_index do |port, _i|
      sector_props = @ports.empty? ? port_preset(port) : @ports.pop[1]
      PortCreatorService.call(sector_props)
    end
  end
end
