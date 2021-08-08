class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      @messages = Message.all
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    redirect_to room_path(@message.room_id)
  end


private

  def message_params
    params.require(:message).permit(:room_id, :body)
  end


end
