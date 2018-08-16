class PlayerSerializer < ActiveModel::Serializer
  attributes :username, :rank, :exp, :times_destroyed, :corp, :ship_name, :ship_info, :ship_date_built, :turns_per_warp, :current_sector, :turns, :holds, :total_holds, :fighters, :credits

  def times_destroyed
  end

  def corp
    nil unless object.in_a_corporation?
    {
      corporation_id: object.corporation_id
    }
  end

  def ship_name
    object.primary_ship.name
  end

  def ship_info
    object.primary_ship.info
  end

  def ship_date_built
    object.primary_ship.created_at
  end

  def turns_per_warp
    object.primary_ship.ship_type.turns_per_warp
  end

  def fighters
   object.primary_ship.fighters
  end

  def total_holds
    {
     total: object.primary_ship.total_holds, 
     empty: object.primary_ship.empty_holds
    }
  end

  def holds
   object.primary_ship.hold_contents
  end

end
