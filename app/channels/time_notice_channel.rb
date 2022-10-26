class TimeNoticeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "time_notice"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
