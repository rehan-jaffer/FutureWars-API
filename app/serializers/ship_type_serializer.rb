class ShipTypeSerializer < ActiveModel::Serializer
  attributes :name, :description, :cost, :capabilities

  def capabilities
    {
      transwarp_drive: object.transwarp_drive,
      photon_missiles: object.photon_missiles,
      planet_scanner: object.planet_scanner,
      #      max_genesis: object.max_genesis,
      max_fighters: object.max_fighters,
      max_fighters_per_attack: object.max_fighters_per_attack,
      max_shields: object.max_shields,
      max_holds: object.max_holds
    }
  end

  def cost
    {
      basic_hold_cost: object.basic_hold_cost,
      main_drive_cost: object.main_drive_cost,
      computer_cost: object.computer_cost,
      ship_hull_cost: object.ship_hull_cost,
      ship_base_cost: object.ship_base_cost
    }
  end
end
