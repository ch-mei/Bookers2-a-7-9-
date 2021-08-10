class ChatsController < ApplicationController
    def show
    @user = User.find(params[:id])#チャット相手の詳細ページから遷移するので、相手のuser_id
    rooms = current_user.entries.pluck(:room_id)#user_roomテーブルから、自分(current_userが所属するレコードを参照し、レコードのroom_idを配列で取得
    entry = Entry.find_by(user_id: @user.id, room_id: rooms)
    #user_idが相手(@user)で、room_idが自分の属するroom_id（配列）となるentriesテーブルのレコードを取得して、entries変数に格納
    #これによって、自分と相手に共通のroom_idが存在していれば、その共通のroom_idと相手のuser_idがuser_room変数に格納される(user_roomテーブルの1レコード）。存在しなければ、nilになる。

    if entry.nil?
      room = Room.new
      room.save

      #二人分のentryテーブルのレコードを作成する(上２行で作成したroomに基づく)
      Entry.create(user_id: @user.id, room_id: room.id)#相手のidをuser_idとしたレコード
      Entry.create(user_id: current_user.id, room_id: room.id)#自分のidをuser_idとしたレコード
    else
      @room = entry.room#自分と相手が共通して持っているroomのレコードを格納
    end

    @chats = @room.chats#@roomに紐づくchatsテーブル
    @chat = Chat.new(room_id: @room.id)#新規チャット投稿の際のroom_idを先に指定している
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
