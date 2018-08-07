require './lib/universe/stages/sector_stage'
require './lib/universe/stages/warp_stage'
require './lib/universe/stages/port_stage'
require './lib/universe/stages/destroy_stage'

class UniverseCreator
  def initialize(size)
    @size = size
    @stages = stages
  end

  def add_stage(stage)
    @stages.push(stage)
  end

  def create
    puts '[*] Creating Universe...let there be light!'
    @stages.each do |stage|
      puts "[*] Executing #{stage}.."
      s = stage.new
      s.set_size(@size)
      s.exec
    end
  end

  private

    def stages
      [DestroyStage, SectorStage, WarpStage, PortStage]
    end

end
