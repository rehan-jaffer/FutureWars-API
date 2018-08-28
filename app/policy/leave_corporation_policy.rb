require './lib/mixins/policy_object'

class LeaveCorporationPolicy

    include PolicyObject

    def initialize(player, corp_id)
      @player = player
      @corp_id = corp_id
    end

    def conditions
        [
          ['Corporation does not exist', Corporation.exists?(@corp_id)],
          ['You are not in this corporation', @player.in_corporation?(@corp_id)]
        ]
    end

end
