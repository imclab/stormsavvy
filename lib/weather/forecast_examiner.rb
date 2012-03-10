
require 'csv'


class ForecastExaminer

  attr_accessor :forecast
  attr_reader :rain

  @@imminent   = (0..4).to_a.map {|e| e*6}
  @@warning    = (5..8).to_a.map {|e| e*6}
  @@watch      = (9..28).to_a.map {|e| e*6}

  def initialize(forecast)
    @forecast = forecast
  end

  def find_rain_chance(pop = 50, interval = 6)
    index = @forecast[0].map.with_index do |f,i|
      (f.to_i >= pop) ? i : nil
    end
    # compact return a copy of the array with nil elements removed
    forecast = index.compact.map { |e| e*6 }
    set_rain_state(forecast)
  end

  private

  def set_rain_state(forecast)
    case
    when (@@imminent & forecast).any?
      @rain = :imminent
    when (@@warning & forecast).any?
      @rain = :warning
    when (@@watch & forecast).any?
      @rain = :watch
    else
      @rain = :clear
    end
  end

end
