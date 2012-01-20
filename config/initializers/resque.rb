require 'resque'
require 'resque-retry'
require 'resque/failure/redis'
require 'resque-timeout'

Resque.redis.namespace = "resque:GameChecker"

Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
Resque::Plugins::Timeout.timeout = 600
Resque::Plugins::Timeout.switch = :on
