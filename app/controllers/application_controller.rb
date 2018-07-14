class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequestService.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end
end
