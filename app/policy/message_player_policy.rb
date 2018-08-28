require './lib/mixins/policy_object'

class MessagePlayerPolicy
  
  include PolicyObject

  def initialize
    @to_id = to_id
    @from_id = from_id
    @message = message
  end

  def conditions
    [
      ['No known trader with this name', @to_id],
      ['Please specify a message', @message]
    ]
  end
end