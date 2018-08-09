class CreateCorporationService

  prepend SimpleCommand

  def initialize(current_user_id, corporation_name)
    @current_user = Player.find(current_user_id)
    @corporation_name = corporation_name
  end

  def validates?
    errors.add(:errors, "Must specify a corporation name") unless @corporation_name
    errors.add(:errors, "You are already in a corporation") if @current_user.in_a_corporation?
    errors.empty?
  end

  def call()
    return nil unless validates?
    corp = Corporation.create(name: @corporation_name, ceo_id: @current_user.id, creator_id: @current_user.id)
    JoinCorporationService.call(@current_user.id, corp.id)
    corp
  end

end
