require './lib/events/event_emitter'

class CreateCorporationService
  include EventEmitter
  prepend SimpleCommand

  def initialize(current_user_id, corporation_name)
    @current_user = Player.find(current_user_id)
    @corporation_name = corporation_name
    streams(["universe", "player-#{current_user_id}"])
  end

  def validates?
    errors.add(:errors, "Must specify a corporation name") unless @corporation_name
    errors.add(:errors, "You are already in a corporation") if @current_user.in_a_corporation?
    errors.empty?
  end

  def update_events
    emit_event(CorporationCreated, {creator_id: @current_user.id, corp_id: @corp.id})
  end

  def call()
    return nil unless validates?
    @corp = Corporation.create(name: @corporation_name, ceo_id: @current_user.id, creator_id: @current_user.id)
    JoinCorporationService.call(@current_user.id, @corp.id)
    stream_add("corporation-#{@corp.id}")
    update_events
    @corp
  end

end
