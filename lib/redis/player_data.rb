class PlayerData
  def initialize(redis)
    @redis = redis
  end

  def explored_sectors(user_id)
    redis.smembers("#{user_id}_explored")
  end

  def explored_sector(user_id, sector)
    redis.sadd("#{user_id}_explored", sector)
  end
end
