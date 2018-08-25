class Density

  def self.anom?(sector)
    sector.cloaked_ships_present? || sector.limpet_mines_present?
  end

  def self.value(sector)
   [
     planet_density(sector.planets.size),
     ship_density(sector.players_in_sector.count),
     nav_hazard_density(sector.nav_hazard)
   ].inject(:+)
  end

  def self.planet_density(planets)
    500 * planets
  end

  def self.ship_density(ships)
    40 * ships
  end

  def self.nav_hazard_density(naz_hazard)
    21 * (naz_hazard / 100)
  end

end
