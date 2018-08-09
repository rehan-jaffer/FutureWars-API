class EventLogger

  def initialize(logger)
    @logger = logger
  end

  def call(event)
    @logger.warn("#{event.type.to_s} with #{event.data.inspect}")
  end

end
