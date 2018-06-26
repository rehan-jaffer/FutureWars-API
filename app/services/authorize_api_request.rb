require './lib/user_auth_json'

class AuthorizeApiRequest
  prepend SimpleCommand
  include UserAuthJson

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end
end
