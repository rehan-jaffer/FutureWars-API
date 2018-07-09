class Api::AuthController < ApplicationController
  skip_before_action :authenticate_request

  def create
    command = AuthenticateUserService.call(user_params['username'], user_params['password'])
    if command.success?
      render json: { auth_token: command.result }, status: :ok
    else
      render json: { errors: command.errors }, status: :unauthorized
    end
  end

  def user_params
    params.permit(:username, :password)
  end
end
