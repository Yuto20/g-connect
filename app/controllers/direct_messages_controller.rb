class DirectMessagesController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.entries.pluck(:room_id)
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)

    if entries.nil?
      @room = Room.new
      @room.save
      Entry.create(user_id: @user.id, room_id: @room.id)
      Entry.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = entries.room
    end
    @direct_messages = @room.direct_messages.order(created_at: :desc)
    @direct_message = DirectMessage.new(user_id: @user.id, room_id: @room.id)
  end

  def create
    @direct_message = current_user.direct_messages.new(direct_message_params)
    if @direct_message.save
      ActionCable.server.broadcast 'direct_message_channel',{content: @direct_message, created_at: @direct_message.created_at, nickname: @direct_message.user.nickname}
    end
  end

  private
  def direct_message_params
    params.require(:direct_message).permit(:content, :room_id)
  end
end
