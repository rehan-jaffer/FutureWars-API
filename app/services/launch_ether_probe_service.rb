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
        ether_map << SectorSerializer.new(Sector.find(sector_id), scope: @player).to_json
      end
      ether_map
    rescue e
      puts "some shit went down"
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
