module DashboardHelper

require 'weather/noaa_forecast'

  def chance_of_rain(zip)
    zip = 90210 unless zip.present?
    nf = NOAAForecast.new(zip)
    nf.seven_day_temp(zip)
    nf.noaa_forecast[0][0..4].max
  end

end
