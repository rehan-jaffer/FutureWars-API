class MessagePlayerService
  prepend SimpleCommand

  def initialize(from_id, to_user, message)
    @from_id = from_id
    @to_id = Player.where(username: to_user).first.try(:id)
    @message = message
  end

  def call
    
    policy = MessagePlayerPolicy.new(@from_id, @to_id, @message)
    
    if policy.success?
      Message.create(from_id: @from_id, to_id: @to_id, message: @message)
    else
      errors.add(:errors, policy.error)
      nil
    end

  end
end
