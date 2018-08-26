module EventEmitter

  def translate(event_name_symbol)
    event_name_symbol.to_s.split('_').map(&:capitalize).join('')
  end
 
  def streams2(*objects)
    @streams = ["universe"] + objects.map { 
      |object|
        object.stream_id
    }
  end

  def streams(streams)
    @streams = streams
  end

  def stream_add(stream)
    @streams.push(stream)
  end

  def stream_add2(object)
    @streams.push(object.stream_id)
  end

  def emit(event, data_fields)
    klass = Object.const_get(translate(event))
    @streams.each do |s|
      event_store.publish(klass.new(data: data_fields), stream_name: s)
    end
  end

  def emit_event(event, data_fields)
    @streams.each do |s|
      e = event.new(data: data_fields)
      event_store.publish(e, stream_name: s, expected_version: :auto)
    end
  end

  def event_store
    Rails.configuration.event_store
  end

end
