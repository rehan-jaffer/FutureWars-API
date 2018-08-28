require './lib/events/event_emitter'

class CreateCorporationService
  include EventEmitter
  prepend SimpleCommand

  def initialize(current_user_id, corporation_name)
    @current_user = Player.find(current_user_id)
    @corporation_name = corporation_name
    streams2 @current_user
  end

  def update_events
  end

  def call
    corporate_policy = CreateCorporationPolicy.new(@current_user, @corporation_name)

    if corporate_policy.denied?
      errors.add(:errors, corporate_policy.error)
      return nil
    end

    if corporate_policy.allowed?
      @corporation = Corporation.create(name: @corporation_name, ceo_id: @current_user.id, creator_id: @current_user.id)
      JoinCorporationService.call(@current_user.id, @corporation.id)
      stream_add2 @corporation
      emit :corporation_created, creator_id: @current_user.id, corporation_id: @corporation.id, corporation_name: @corporation.name
      @corporation
    end
  end
end
