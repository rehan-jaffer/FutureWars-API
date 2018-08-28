require './lib/mixins/policy_object'

class CreatePlayerPolicy

  include PolicyObject

  def initialize(username, password, ship_name)
    @username = username
    @password = password
    @ship_name = ship_name
  end

  private

  def conditions
    [
      ['No username supplied', @username],
      ['No password supplied', @password],
      ['No ship name supplied', @ship_name]
    ]
  end

end