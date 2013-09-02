# ruby script for testing redis in rails console
zipcode = 94530
nf = NOAAForecast.new(zipcode,168,6)
lat_long = nf.get_lat_long(zipcode)
$redis.set(zipcode.to_s + '_lat', lat_long[0])
$redis.set(zipcode.to_s + '_long', lat_long[1])
nf.return_lat_long(zipcode)