module Patterns
  def self.ids
    (0..1000).to_a.shuffle
  end
  def self.square(n)
    Array.new(n).map { |a| Array.new(n, 1) }
  end
  def self.neighbours(square, i, j)
    n = square.size
    neighbours = []
    (-1).upto(1) do |x|
      (-1).upto(1) do |y|
        next if x == 0 && y == 0
        begin
          neighbours.push(square[(i+x) % n][(j+y) % n]) if square[(i+x) % n][(j+y) % n].to_i > 0
        end
      end
    end
    neighbours
  end
  def self.filter(square, id_list)
    n = square.size
    new_square = square(n)
    0.upto(n-1) do |i|
      0.upto(n-1) do |j|
        if rand > 0.7
          new_square[i][j] = 0
        else
          new_square[i][j] = id_list.pop
        end
      end
    end
    new_square
  end
end
