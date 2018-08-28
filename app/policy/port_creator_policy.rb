class PortCreatorPolicy

  include PolicyObject

  def initialize(sector_id, port_class)
    @sector_id = sector_id
    @port_class = port_class
  end

  def conditions
    [
      ['Sector must exist', Sector.exists?(@sector_id)],
      ['No Port Class supplied', @port_class]
    ]
  end
end
