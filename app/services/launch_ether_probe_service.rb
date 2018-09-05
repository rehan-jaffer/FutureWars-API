require './lib/sector/sector_events'

class LaunchEtherProbeService

  prepend SimpleCommand

  def initialize(player, dest)
    @player = player
    @dest = dest
  end

  def call
   @policy = LaunchEtherProbePolicy.new(@player, @dest)
   @policy.allowed? ? handle_success : handle_failure
  end

  private

#    def policy
#      @policy ||= LaunchEtherProbePolicy.new(@player, @dest)
#    end

    def handle_success
      ether_map = []
      warp_path.each do |sector_id|
        sector = Sector.find(sector_id)
        sector_events = SectorEvents.new(sector, @player)
        if sector_events.has_events?(:probe)
          event = sector_events.get_events(:probe)
          break if event.run
        else  
          ether_map << SectorSerializer.new(sector, scope: @player).to_json
        end
      end
      ether_map
    end

    def handle_failure
      puts @policy
      errors.add(:error, @policy.error)
      nil
    end

    def warp_path
      @path ||= Warp.path(@player.current_sector, @dest)
    end

end
