require 'redis'

REDISTOGO_URL = "redis://localhost:6379/"
uri = URI.parse(REDISTOGO_URL)
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

=begin
$redis = Redis.new(:host => 'localhost', :port => 6379)

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
