class SectorStage
  def initialize
    @size = 0
    @sectors = YAML.safe_load(File.read('./maps/sector.yml'))
  end

  def set_size(size)
    @size = size
  end

  def announce
    puts '[*] Creating Sectors...'
  end

  def exec
    @size.times do |i|
        (sectors['Sectors'][i]) ? SectorCreatorService.call(sectors['Sectors'][i]) : SectorCreatorService.call
      end
  end
end
