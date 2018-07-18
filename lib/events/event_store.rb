class EventStore

  @@commit_id = $redis.hlen("EventStore")

  def self.commit_id
    @@commit_id
  end

  def self.stream(stream_name, commit_id)
    $redis.rpush(stream_name, commit_id)
  end

  def self.stream_len(stream_name)
    $redis.llen(stream_name)
  end

  def self.stream_publish(stream, id)
    $redis.publish(stream, id)
  end

  def self.publish(event, streams)
    $redis.hset("EventStore", @@commit_id, event.serialize.to_json)
    streams.each do |stream|
      stream(stream, @@commit_id)
      stream_publish(stream, @@commit_id)
    end
    @@commit_id += 1
  end

  def self.events_count
    $redis.hlen("EventStore")
  end

  def self.events
    $redis.hmget("EventStore", (0..@@commit_id).to_a).map do |item|
      next unless item
      begin
        JSON.parse(item)
      rescue
      end
    end
  end

end

class Event

  def initialize(event_name, event_props)
    @event_name = event_name
    @event_props = event_props
  end

  def serialize
    {event_name: @event_name}.merge(@event_props)
  end

end
