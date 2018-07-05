$SECTORS = []

def sector(num)
  $num = num
  $SECTORS[$num] = { id: $num }
  yield
end

def sector_set(key, value)
  $SECTORS[$num][key] = value
end

def colonists(n)
  sector_set('colonists', n)
end

def equipment(n)
  sector_set('equipment_qty', n)
end

def ore(n)
  sector_set('ore_qty', n)
end

def organics(n)
  sector_set('organics_qty', n)
end

def set_home_sector
  sector_set('home_sector', true)
end

def add_port(type)
  sector_set('has_port', true)
  sector_set('port_class', PortTradeString.get_class(type))
end

def set_fedlaw_beacon
  sector_set('federation_space', true)
end
