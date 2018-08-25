class MessagePlayerService
  prepend SimpleCommand

  def initialize(from_id, to_user, message)
    @from_id = from_id
    @to_id = Player.where(username: to_user).first.try(:id)
    @message = message
  end

  def validates?
    errors.add(:errors, 'No known trader with this name') unless @to_id
    errors.add(:errors, 'Please specify a message') unless @message
    errors.empty?
  end

  def call
    return nil unless validates?
    Message.create(from_id: @from_id, to_id: @to_id, message: @message)
  end
end
