require './lib/events/event_emitter'

class JoinCorporationService
  prepend SimpleCommand
  include EventEmitter

  def initialize(user_id, corp_id)
    @player = Player.find(user_id)
    @corp_id = corp_id
    streams (['universe', 'corporations', "corporation-#{corp_id}"])
  end

  def call

    policy = JoinCorporationPolicy.new(@player, @corp_id)    

    if policy.allowed?
      @corp = Corporation.find(@corp_id)
      @player.update_attribute(:corporation_id, @corp.id)
      emit :player_joined_corporation, player_id: @player.id, corporation_id: @corp.id
      return @corp
    else
      errors.add(:errors, policy.error)
      return nil
    end

  end
end
