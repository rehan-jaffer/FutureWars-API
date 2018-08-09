class ExperienceTracker
  def call(event)
    case event.type
      when PlayerMoved
        Player.find(event.data[:player_id]).increment!(:exp, 2)
    end
  end
end
