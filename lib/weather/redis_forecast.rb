require 'redis'
require 'weather/noaa_forecast'

class RedisForecast

  def set_lat_long(zipcode)
    nf = NOAAForecast.new(zipcode)
    lat_long = nf.get_lat_long(zipcode)
    $redis.set('lat', lat_long[0])
    $redis.set('long', lat_long[1])
  end

  def get_lat_long(zipcode)
    nf = NOAAForecast.new(zipcode)
    lat_long = nf.get_lat_long(zipcode)
    $redis.zadd(zipcode, lat_long[0], lat_long[1])
    return $redis.get('zipcode')
  end
end
