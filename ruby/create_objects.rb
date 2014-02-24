# Generates objects in console
time = Time.new
values = time.to_a
p values

zipcode = 94901
nf = NOAAForecast.new(zipcode)
forecast = nf.seven_day_weather(zipcode)

# Precipitation_state via forecast
site = Site.new(name: 'ecp', zipcode: 94530)
site.save
forecast = site.forecast
site.precipitation_state(forecast)

# User/site relationship
user = User.new(
  email: 'name@stormsavvy.com',
  password: 'stormpopwho?',
  password_confirmation: 'stormpopwho?'
)
user.save
site = user.sites.new(
  name: 'ecp',
  zipcode: 94530
)
site.save
site.user
site.wg_forecast = site.save_wg

wg = WeatherGetter.new
wg.get_forecast(site.zipcode)

site.lat
site.long

# Associates site with forecast, then save it
noaa = NoaaForecastService.new(:site => site)
noaa.get_forecast
noaa.save_results

# Logic inside chance_of_rain method
site.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).map(&:pop)
ForecastPeriod.where('pop = ?', 66)
site.chance_of_rain
site.dashboard_pop(site)
