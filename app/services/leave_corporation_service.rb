require './lib/events/event_emitter'

class LeaveCorporationService
  prepend SimpleCommand
  include EventEmitter

  def initialize(user_id, corp_id)
    @player = Player.find(user_id)
    @corp_id = corp_id
    streams(['universe', 'corporations', "corporation-#{corp_id}"])
  end

  def call
    policy = LeaveCorporationPolicy.new(@player, @corp_id)

    if policy.denied?
      errors.add(:errors, policy.error)
      return nil
    end

    if policy.allowed?
      emit :player_left_corporation, player_id: @player.id, corporation_id: @corp_id
      @player.update_attribute(:corporation_id, nil)
      @player
    end
  end
end
