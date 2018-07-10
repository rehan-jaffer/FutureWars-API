require './lib/universe/stages/sector_stage'
require './lib/universe/stages/warp_stage'

class UniverseCreator
  def initialize(size)
    @size = size
    @stages = []
  end

  def add_stage(stage)
    @stages.push(stage)
  end

  def create
    puts "Creating Universe...let there be light!"
    @stages.each do |stage|
      s = stage.new
      s.set_size(@size)
      s.exec
    end
  end
end