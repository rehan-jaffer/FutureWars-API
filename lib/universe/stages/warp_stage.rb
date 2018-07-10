class WarpStage
  def initialize
    @size = 0
  end
  def set_size(size)
    @size = size
  end
  def announce
    puts "Creating Warp Network..."
  end
  def exec
    warp_function = -> (_x) { (rand * 5).round }
    sector_list = Sector.all.map(&:id)
    sector_list.each do |sector|
      Sector.create_warps(sector, sector_list, warp_function)
    end
  end
end
