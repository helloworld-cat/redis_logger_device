module RedisLoggerDevice
  DEFAULT_QUEUE_NAME = 'logger:logs'

  class Base
    attr_reader :redis

    def initialize(queue_name=DEFAULT_QUEUE_NAME, redis_opts={})
      @queue_name = queue_name
      @redis = Redis.new(redis_opts)
    end

    def write(msg)
      @redis.lpush @queue_name, msg.strip
    end

    def queue_size
      s = -1
      s = @redis.llen @queue_name
      return s
    end

    def flush
      i = 0
      while redis.rpop(@queue_name) do
        i += 1
      end
      return i 
    end

    def close
      @redis.quit
    end
  end

end
