require 'weather/noaa_forecast'
require 'weather/forecast_examiner'
require 'current_user_object'

module DashboardHelper

  attr_reader :rain_state, :max_rain

  def chance_of_rain(zipcode)
    zipcode = 90210 unless zipcode.present?
    nf = NOAAForecast.new(zipcode)
    nf.seven_day_weather(zipcode)
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

  def get_projects
    @projects = CurrentUserObject::get_projects
  end
end
