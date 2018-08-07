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

    square_size = (@size**0.5).ceil
    grid = Patterns.square(square_size)
    pattern_grid = Patterns.filter(grid, @sector_list)

    0.upto(square_size-1) do |i|
      0.upto(square_size-1) do |j|
        sector_id = pattern_grid[i][j]
        next unless sector_id
        Patterns.neighbours(pattern_grid, i, j).each do |neighbour|
          Warp.create(origin_id: sector_id, dest_id: neighbour) if neighbour && neighbour > 0
        end
      end
    end

    File.write("./config/grid.#{Rails.env}.map", JSON.generate(pattern_grid))

  end
end

