require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
  Sidekiq::Cron::Job.load_from_hash! YAML.load_file(Rails.root.join('config', 'sidekiq_cron.yml'))
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end