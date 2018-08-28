class JoinCorporationPolicy
  include PolicyObject

  def initialize(player, corp_id)
    @player = player
    @corp_id = corp_id
  end

    def conditions
      [
        ['Corporation does not exist', Corporation.exists?(@corp_id)],
        ['You are already in a corporation, leave first', @player.in_a_corporation? == false]
      ]
    end

end
