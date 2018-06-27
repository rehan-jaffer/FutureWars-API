class CreatePlayer
  prepend SimpleCommand

  def initialize(username, password, ship_name)
    @username = username
    @ship_name = ship_name
    @password = password
  end

  def call
    player = Player.create(username: @username,
                           ship_name: @ship_name,
                           ship_type_id: 1,
                           holds: Rails.configuration.game['initial_holds'],
                           turns: Rails.configuration.game['initial_turns'],
                           current_sector: Rails.configuration.game['initial_sector'],
                           fighters: Rails.configuration.game['initial_fighters'],
                           credits: Rails.configuration.game['initial_credits'],
                           password: @password)

    if player.errors
      errors.add(:create, "Couldn't save")
    else
     Universe.event(:player_created, player.id)
     player
    end
  end
end
