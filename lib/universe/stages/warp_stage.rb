require './lib/grid/patterns'

class WarpStage
  def initialize
    @size = 0
    @sector_list = Sector.all.map(&:id)
    @warp_function = ->(_x) { (rand * 5).round }
  end

  def set_size(size)
    @size = size
  end

  def announce
    puts 'Creating Warp Network...'
  end

  def exec
    @sector_list.each do |sector|
      Sector.create_warps(sector, @sector_list, @warp_function)
    end
  end
end
