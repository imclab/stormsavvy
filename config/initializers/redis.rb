require 'redis'
require 'uri'

rails_env = ENV['RAILS_ENV'] || 'development'

if rails_env == 'production'
  $redis = Redis.new(:host => 'stormsavvy.com')
elsif rails_env == 'staging'
  $redis = Redis.new(:host => 'staging.stormsavvy.com')
else
  $redis = Redis.new(:host => 'localhost', :port => 6379)
end

=begin
REDISTOGO_URL = "redis://localhost:6379/"
uri = URI.parse(REDISTOGO_URL)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

uri = URI.parse(ENV["REDISTOGO_URL"] || "redis://localhost:6379/" )
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

$redis = Redis.new(url: ENV["REDISTOGO_URL"])

uri = URI.parse(ENV['REDISTOGO_URL'])
begin
  $redis ||= Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  $redis.keys # needed to know if connection failed
  REDIS = $redis
rescue
  puts("Redis not loaded on #{uri.port}")
  REDIS = nil
end
=end
