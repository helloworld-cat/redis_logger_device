# RedisLoggerDevice

With this library, you can inject log into Redis queue and process it this worker

## Installation

Clone from github repository:

    $ git clone git@github.com:PagedeGeek/redis_logger_device.git

Build Gem:

    $ gem build ./redis_logger_device.gemspec

Install it yourself as:

    $ sudo gem install ./redis_logger_device-0.0.1.gem 

## Usage

### In your application use Redis Device

``` ruby
require 'logger'
require 'redis_logger_device'

dev = RedisLoggerDevice::Base.new
logger = Logger.new(dev)

logger.info("AAAAAaaaaaahhhhh")

logger.close
```

---

### Make your Logger Worker in background for process log entries

``` ruby
require 'logger'
require 'redis_logger_device'

include RedisLoggerDevice

class SimpleLogWorker < LogWorker
  def process_queue!
    loop do
      begin
        @logger.info("LogWorker fetching (#{@queue_name})...")
        key, val = @redis.brpop @queue_name
        @logger.info("LogWorker rocess key: #{key}; val: #{val}")

        #your code : val = log entry

      rescue SignalException => e
        raise e
      rescue Exception => e
        @logger.fatal "LogWorker error: #{e.message}"
        raise e
      end
    end
  end
end

worker_logger = Logger.new(STDOUT)
worker = SimpleLogWorker.new(worker_logger)

worker.process_queue!

worker_looger.close
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
