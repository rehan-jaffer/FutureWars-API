class SectorSerializer < ActiveModel::Serializer
  attributes :id, :players, :port, :warps, :planets, :nav_hazard

  #  private

  def nav_hazard
    object.nav_hazard.to_f / 100.0
  end

  def port
    return nil unless object.port && object.port['name']
    {
      name: object.port['name'],
      port_class: object.port['port_class'],
      trades: object.port.trades
    }
  end

  def warps
    Warp.warps_for(object.id).map do |warp|
      { warp: warp, explored: scope.explored?(warp) }
    end
  end

  def planets
    object.planets.map do |planet|
      {
        name: planet.name,
        classification: planet.planet_type.classification,
        planet_type: planet.planet_type.name
      }
    end
  end

  def players
    object.players_in_sector
          .all
          .reject { |player| player.username == scope.username }
          .map do |player|
      {
        name: player.username,
        rank: player.rank.to_s,
        fighters: player.primary_ship.fighters,
        ship: player.ship_name,
        ship_type: player.primary_ship.ship_type.name
      }
    end
  end
end
