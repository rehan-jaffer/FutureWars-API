require 'jwt'

class AuthenticateUser
  prepend SimpleCommand
  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    JsonWebToken.encode(player_id: user.id) if user
   end

  attr_accessor :username, :password

  def user
    user = Player.find_by(username: @username)
    return user if user && user.authenticate(@password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
