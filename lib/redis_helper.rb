module RedisHelper
  def get_redis(key)
    $redis.get(key)
  end

  def expire_token(life)
    $redis.expire(:token, life)
  end

  def set_redis(key, value)
    $redis.set(key, value)
  end
end