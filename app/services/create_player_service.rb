class CreatePlayerService
  prepend SimpleCommand

  def initialize(username, password, ship_name)
    @username = username
    @ship_name = ship_name
    @password = password
  end

  def call
    player = Player.create(username: @username,
                           ship_name: @ship_name,
                           ship_type_id: ShipType.find_by_name('Merchant Cruiser').id,
                           alignment: 0,
                           holds: Rails.configuration.game['initial_holds'],
                           turns: Rails.configuration.game['initial_turns'],
                           current_sector: Rails.configuration.game['initial_sector'],
                           fighters: Rails.configuration.game['initial_fighters'],
                           credits: Rails.configuration.game['initial_credits'],
                           password: @password)

    return player if player.errors.empty?
    errors.add(:errors, "Couldn't save")
    player.errors.full_messages.each { |error| errors.add(:errors, error) }
    nil
  end
end
