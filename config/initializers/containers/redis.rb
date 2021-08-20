class Containers
  def redis
    Redis.new(Settings.redis.to_h)
  end

  cattr_reader(:redis, instance_reader: false, default: new.redis)
end
