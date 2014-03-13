require 'raven'

logger = ::Logger.new(STDOUT)
logger.level = ::Logger::WARN

Raven.configure do |config|
  config.dsn = 'https://425c55e5fc1d4e088fa0ba111885690a:553a3532c4a645848944adb6dafbc45b@app.getsentry.com/5755'
  config.processors = [Raven::Processor::SanitizeData]
  config.logger = logger
end
