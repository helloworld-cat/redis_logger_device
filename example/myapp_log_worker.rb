require 'logger'
require 'redis_logger_device'

include RedisLoggerDevice

class SimpleLogWorker < LogWorker
  def process_queue!
    loop do
      begin
        # @logger.info("LogWorker fetching (#{@queue_name})...")
        key, val = @redis.brpop @queue_name
        # @logger.info("LogWorker rocess key: #{key}; val: #{val}")

        #your code : val = log entry
        puts "Log entry found: #{val}"

      rescue SignalException => e
        raise e
      rescue Exception => e
        @logger.fatal "LogWorker error: #{e.message}"
        raise e
      end
    end
  end
end

redis_opts = {
  host: '50.30.35.9',
  port: 2421,
  password: ''
}

worker_logger = Logger.new(STDOUT)
worker = SimpleLogWorker.new(worker_logger, 'myapp:logs', redis_opts)

worker.process_queue!

worker_looger.close

