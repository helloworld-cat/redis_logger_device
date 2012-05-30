require 'logger'
require_relative '../lib/redis_logger_device'

dev = RedisLoggerDevice::Base.new
dev.flush
logger = Logger.new(dev)

logger.info "Message 1"
logger.warn "Message 2"
logger.error "Message 3"

logger.close

