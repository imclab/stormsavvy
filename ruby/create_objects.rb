# generates objects in console
user.delete
project.delete
site.delete
site2.delete
reload!
user = User.new(
	:email => 'walter@stormsavvy1.com',
	:password => 'foobar1'
	)
user.save
project = user.projects.new(
  :name => 'ec park and rec',
  :description => 'playground improvements',
  :startdate => DateTime.new(2011),
  :finishdate => DateTime.new(2012)
  )
project.save
site = project.sites.new(
  :name => 'ec jungle gym',
  :zipcode => 94530
  )
site.save
site2 = project.sites.new(
  :name => 'ec playground',
  :zipcode => 94530
  )
site2.save

sites = user.sites
puts sites

user.sites.each do |s|
  site = pp s.name
  pp site
end

we = WeatherEvent.new
we.save

project = Project.new(:name => 'foo', :description => 'bar')
project.save
sites = project.sites.build

report = ReportsPdf.new
report.testem_fields

email = "walter@stormsavvy.com"
AlertMailer.pester_admins(email).deliver

zipcode = 94901
nf = NOAAForecast.new(zipcode)
forecast = nf.seven_day_weather(zipcode)

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
