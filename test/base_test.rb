
require 'test/unit'
require 'logger'

require_relative '../lib/redis_logger_device'

class BaseTest < Test::Unit::TestCase

  def setup
    # logger = Logger.new(RedisDevice.new)
    # logger.level = Logger::INFO

    # logger.info("INFO MSG")
    # logger.warn("WARNING MSG")
    # logger.error("ERROR MSG")

    # logger.close 
  end

  def test_create
    device = RedisLoggerDevice::Base.new(RedisLoggerDevice::DEFAULT_QUEUE_NAME)
    assert_not_nil device

    logger = Logger.new(device) 
    assert_not_nil logger

    assert_not_nil device.redis

    device.redis.set 'mykey', 'myvalue'
    assert_equal 'myvalue', device.redis.get('mykey')

    assert_nothing_raised(Exception) { logger.close }
  end

  def add_log_flush_get_size
    dev = RedisLoggerDevice.new
    dev.flush
    logger = Logger.new(dev)
    logger.info 'Message one'
    logger.info 'Message two'

    assert_equal 2, dev.queue_size

    logger.close
  end

end
