require './lib/events/event_emitter'

class CreateCorporationService
  include EventEmitter
  prepend SimpleCommand

  def initialize(current_user_id, corporation_name)
    @current_user = Player.find(current_user_id)
    @corporation_name = corporation_name
    streams2 @current_user
  end

  def call
    @policy = CreateCorporationPolicy.new(@current_user, @corporation_name)
    @policy.allowed? ? handle_success : handle_failure
  end

  def handle_success
    @corporation = Corporation.create(name: @corporation_name, ceo_id: @current_user.id, creator_id: @current_user.id)
    JoinCorporationService.call(@current_user.id, @corporation.id)
    stream_add2 @corporation
    emit :corporation_created, creator_id: @current_user.id, corporation_id: @corporation.id, corporation_name: @corporation.name
    @corporation
  end

  def handle_failure
    errors.add(:errors, @policy.error)
    return nil
  end

end
