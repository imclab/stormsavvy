module DashboardHelper

require 'weather/noaa_forecast'

  def chance_of_rain(zip)
    zip = 90210 unless zip.present?
    nf = NOAAForecast.new(zip)
    forecast = nf.seven_day_temp(zip)
    return forecast[0][0..4].max
  end

end
