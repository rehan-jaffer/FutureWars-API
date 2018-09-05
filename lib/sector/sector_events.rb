class SectorEvents

  def initialize(sector, player)
    @sector = sector
    @player = player
  end

  def has_events?(object)

    return case object
      when :probe
       (@sector.has_enemy_fighters?(@player.id))
      when :player
       (@sector.has_enemy_fighters?(@player.id))
      else
       false
    end
  
  end

  def get_events(object)

    return false

    # check for:
    # nav hazard
    # enemy fighters

    case object
      when :probe
        
      when :player
    end    

  end

end

class Event

  def initialize

  end

  def run
  end

end
