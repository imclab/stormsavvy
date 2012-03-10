module DashboardHelper

  def chance_of_rain
    nf = NOAAForecast.new(94530)
    forecast = nf.seven_day_temp(94530)
    return forecast[0][0..4].max
  end
  
end
