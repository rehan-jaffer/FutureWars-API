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
    @size.times do |_i|
      SectorCreatorService.call(false, false)
    end
  end
end
