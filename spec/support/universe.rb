require './lib/universe'

def create_mini_universe
  Universe.create(10)
end

def create_predictable_universe
  Universe.create(10, 0, -> { 3 })
end

def create_closed_universe
  warp_function = -> { 3 }
  Universe.create(3, 0, warp_function)
end
