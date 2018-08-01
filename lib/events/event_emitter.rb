module EventEmitter
  def streams(streams)
    @streams = streams
  end

  def stream_add(stream)
    @streams.push(stream)
  end

  def emit_event(event, data_fields)
    @streams.each do |s|
      e = event.new(data: data_fields)
      Rails.configuration.event_store.publish(e, stream_name: s, expected_version: :auto)
    end
  end
end
