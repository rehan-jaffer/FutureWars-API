class PlayerView
    def self.render(attributes)
    players = Sector.find(attributes["id"]).players
    {"players": players
      .map { |player|
        {
         name: player.username,
         fighters: player.fighters,
         ship: player.ship_name
        }
      }
    }
  end
end