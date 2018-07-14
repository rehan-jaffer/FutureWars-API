class PlayerView
  def self.render(attributes)
    players = Sector.find(attributes['id']).players
    players.map do |player|
      {
        name: player.username,
        rank: player.rank.to_s,
        fighters: player.fighters,
        ship: player.ship_name,
        ship_type: player.ship_type.name
      }
    end
end
end
