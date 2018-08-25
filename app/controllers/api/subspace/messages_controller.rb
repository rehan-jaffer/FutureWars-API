class Api::Subspace::MessagesController < ApplicationRecord
  def send
    result = MessagePlayerService.call(message_params[:username], message_params[:message])
    if result.success?
      render json: result.result
    else
      render json: result.errors
    end
  end

  def list
    render json: current_user.received_messages
  end

  def read
    render json: Message.find(read_message_params[:id])
  end

  private

  def read_message_params
    params.permit(:id)
  end

  def message_params
    params.require(:message).params(:username, :message)
  end
end
