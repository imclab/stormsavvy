# generates objects in console

we = WeatherEvent.new
we.save

time = Time.new
values = time.to_a
p values

zipcode = 94901
nf = NOAAForecast.new(zipcode)
forecast = nf.seven_day_weather(zipcode)
pp forecast

# Script for generating site and forecast periods in console
site = Site.last
site.lat = 38.2470
site.lng = -122.5620
site.save
site.chance_of_rain.pop
noaa = NoaaForecastService.new(:site => site)
noaa.get_forecast
noaa.save_results
site.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map(&:pop)
ForecastPeriod.where('pop = ?', 66)

time = Time.new
values = time.to_a
p values
