require 'logger'
require 'redis_logger_device'

redis_opts = {
  host: '50.30.35.9',
  port: 2421,
  password: ''
}

dev = RedisLoggerDevice::Base.new('myapp:logs', redis_opts)
logger = Logger.new(dev)
# logger.level = Logger::ERROR

# puts dev.queue_size
logger.debug "Debug msg"
logger.info  "Info msg"
logger.warn  "Warn msg"
logger.error "Error msg"
logger.fatal "Fatal msg"

logger.close

