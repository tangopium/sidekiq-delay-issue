require 'sidekiq-unique-jobs'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
  config.logger.level = Logger::DEBUG if config.logger

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end
end

Sidekiq.configure_server do |config|
  config.logger.level = Logger::DEBUG
  config.redis = { url: ENV['REDIS_URL'] }

  config.client_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Client
  end

  config.server_middleware do |chain|
    chain.add SidekiqUniqueJobs::Middleware::Server
  end

  SidekiqUniqueJobs::Server.configure(config)
end