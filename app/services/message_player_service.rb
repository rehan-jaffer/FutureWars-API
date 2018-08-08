class MessagePlayerService

  prepend SimpleCommand

  def initialize(from_id, to_user, message)
    @from_id = from_id
    @to_id = Player.find_by_username(to_user).try(:id)
    @message = message
  end

  def validates?
    errors.add(:errors, "No known trader with this name") if @to_id.nil?
    errors.add(:errors, "Please specify a message") unless @message
    errors.empty?
  end

  def call
    return nil unless validates?
    Message.create(from_id: @from_id, to_id: @to_id, message: @message)
  end

end
