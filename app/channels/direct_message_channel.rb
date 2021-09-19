class DirectMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "direct_message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
