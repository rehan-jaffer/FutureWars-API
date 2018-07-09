class PlayerView
    def self.render(attributes)
    players = Sector.find(attributes["id"]).players
    players.map { |player|
        {
         name: player.username,
         rank: player.rank,
         fighters: player.fighters,
         ship: player.ship_name
        }
     }
  end
end
