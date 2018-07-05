require './lib/port_trade'
require './lib/universe_parser'
require './lib/universe'
require 'pp'

Universe.create(10) do

  sector 0 do
    set_home_sector
    add_port 'Special'
    colonists 1_000_000
  end

  sector 1 do
    set_fedlaw_beacon
    add_port 'SSB'
    equipment 1500
    ore 1500
    organics 1500
  end

  sector 2 do
    set_fedlaw_beacon
    add_port 'BBS'
    equipment 1500
    ore 1500
    organics 1500
  end

end
