# -*- encoding: utf-8 -*-
require File.expand_path('../lib/redis_logger_device/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sam"]
  gem.email         = ["samuel@pagedegeek.com"]
  gem.description   = %q{With this library, you can inject log into Redis queue and process it this worker}
  gem.summary       = %q{Simple Device for Logger}
  gem.homepage      = "https://github.com/PagedeGeek/redis_logger_device"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "redis_logger_device"
  gem.require_paths = ["lib"]
  gem.version       = RedisLoggerDevice::VERSION

  gem.add_development_dependency 'rake'
end
