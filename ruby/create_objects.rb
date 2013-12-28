# generates objects in console
time = Time.new
values = time.to_a
p values

zipcode = 94901
nf = NOAAForecast.new(zipcode)
forecast = nf.seven_day_weather(zipcode)
pp forecast

site = Site.new(name: 'ecp', zipcode: 94530)
site.save
site.lat
site.long

# Associates site with forecast, then save it
noaa = NoaaForecastService.new(:site => site)
noaa.get_forecast
noaa.save_results

# Logic inside chance_of_rain method
site.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map(&:pop)
ForecastPeriod.where('pop = ?', 66)
site.chance_of_rain.pop
