require './lib/events/event_emitter'

class JoinCorporationService

  prepend SimpleCommand
  include EventEmitter

  def initialize(user_id, corp_id)
    @player = Player.find(user_id)
    @corp_id = corp_id
    streams(["universe", "corporations", "corporation-#{corp_id}"])
  end

  def validates?
    errors.add(:errors, "Corporation does not exist") unless Corporation.exists?(@corp_id)
    errors.add(:errors, "You are already in a corporation, leave first") if @player.in_a_corporation?
    errors.empty?
  end

  def update_events
    emit_event(PlayerJoinedCorporation, {player_id: @player.id, corporation_id: @corp.id})
  end

  def call
    return nil unless validates?
    @corp = Corporation.find(@corp_id)
    @player.update_attribute(:corporation_id, @corp.id)
    update_events
    @corp
  end

end
