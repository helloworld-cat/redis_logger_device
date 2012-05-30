module RedisLoggerDevice
  class LogWorker

    def initialize(logger, queue_name=DEFAULT_QUEUE_NAME, redis_opts={})
      @logger = logger
      @queue_name = DEFAULT_QUEUE_NAME
      @redis = Redis.new(redis_opts)
    end

    def process_queue!
      raise NotImplementedError
    end
  end
end
