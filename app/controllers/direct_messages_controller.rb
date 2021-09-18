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
    @direct_messages = @room.direct_messages
    @direct_message = DirectMessage.new(room_id: @room.id)
  end

  def create
    @direct_message = current_user.direct_messages.new(direct_message_params)
    @direct_message.save
  end

  private
  def direct_message_params
    params.require(:direct_message).permit(:content, :room_id)
  end
end
