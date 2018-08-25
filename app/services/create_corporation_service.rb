require './lib/events/event_emitter'

class CreateCorporationService
  include EventEmitter
  prepend SimpleCommand

  def initialize(current_user_id, corporation_name)
    @current_user = Player.find(current_user_id)
    @corporation_name = corporation_name
    streams(['universe', "player-#{current_user_id}"])
  end

  def update_events
    emit_event(CorporationCreated, creator_id: @current_user.id, corporation_id: @corporation.id, corporation_name: @corporation.name)
  end

  def call
    corporate_policy = CreateCorporationPolicy.new(@current_user, @corporation_name)

    unless corporate_policy.allowed?
      errors.add(:errors, corporate_policy.error)
      return nil
    end

    @corporation = Corporation.create(name: @corporation_name, ceo_id: @current_user.id, creator_id: @current_user.id)
    JoinCorporationService.call(@current_user.id, @corporation.id)
    stream_add("corporation-#{@corporation.id}")
    update_events
    @corporation
  end
end
