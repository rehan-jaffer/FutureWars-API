require './lib/events/event_emitter'

class LeaveCorporationService
  prepend SimpleCommand
  include EventEmitter

  def initialize(user_id, corp_id)
    @player = Player.find(user_id)
    @corp_id = corp_id
    streams(['universe', 'corporations', "corporation-#{corp_id}"])
  end

  def validates?
    errors.add(:errors, 'Corporation does not exist') unless Corporation.exists?(@corp_id)
    errors.add(:errors, 'You are not in this corporation') unless @player.in_corporation?(@corp_id)
    errors.empty?
  end

  def update_events
    emit_event(PlayerLeftCorporation, player_id: @user.id, corporation_id: @corp.id)
  end

  def call
    return nil unless validates?
    @player.update_attribute(:corporation_id, nil)
    @player
  end
end
