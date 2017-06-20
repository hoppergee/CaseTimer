class CaseChannel < ApplicationCable::Channel
  def subscribed
    stream_from "case_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def accomplish(data)
  	# binding.pry
  	# ActionCable.server.broadcast 'case_channel', message: "Nice"
  end
end
