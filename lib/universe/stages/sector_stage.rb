class SectorStage
  def initialize
    @size = 0
  end

  def set_size(size)
    @size = size
  end

  def announce
    puts 'Creating Sectors...'
  end

  def exec
    sectors = YAML.safe_load(File.read('./maps/sector.yml'))
    @size.times do |i|
      if sectors['Sectors'][i]
        SectorCreatorService.call(sectors['Sectors'][i])
      else
        SectorCreatorService.call
      end
    end
    pp Sector.pluck(:id)
  end
end
