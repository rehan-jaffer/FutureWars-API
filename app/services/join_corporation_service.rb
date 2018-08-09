require './lib/events/event_emitter'

class JoinCorporationService

  prepend SimpleCommand
  include EventEmitter

  def initialize(user_id, corp_id)
    @player = Player.find(user_id)
    @corp = Corporation.find(corp_id)
    streams(["universe", "corporations", "corporation-#{corp_id}"])
  end

  def validates?
    errors.add(:errors, "Corporation does not exist") unless @corp
    errors.add(:errors, "You are already in a corporation") if @player.in_corporation?
    errors.empty?
  end

  def update_events
    emit_event(PlayerJoinedCorporation, {player_id: @user.id, corporation_id: @corp.id})
  end

  def call
    return nil unless validates?
    @player.update_attribute(:corporation_id, @corp.id)
  end

end