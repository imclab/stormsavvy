module DashboardHelper

=begin
require 'weather/noaa_forecast'
require 'weather/forecast_examiner'

  attr_reader :rain_state, :max_rain

  def chance_of_rain(zipcode)
    zipcode = 90210 unless zipcode.present?
    nf = NOAAForecast.new(zipcode)
    nf.seven_day_weather
    #precipitation_state(nf.noaa_forecast)
    @max_rain = nf.noaa_forecast[0][0..4].max
  end

  def precipitation_state(forecast)
    if forecast == [[],[]]
      @rain_state = :null
      return
    end
    fe = ForecastExaminer.new(forecast)
    fe.find_rain_chance()
    @rain_state = fe.rain
  end
=end

end
