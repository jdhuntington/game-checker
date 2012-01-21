require 'resque'
Resque.redis.namespace = "resque:GameChecker"
Resque::Plugins::Timeout.timeout = 600
Resque::Plugins::Timeout.switch = :on
