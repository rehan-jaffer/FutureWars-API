class Density
  def self.value(sector)
   [
     planet_density(sector.planets.size),
     ship_density(sector.players_in_sector.count),
     nav_hazard_density(sector.nav_hazard)
   ].inject(:+)
  end

  private
  
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
