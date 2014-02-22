require 'csv'

class ForecastExaminer

  attr_reader :forecast
  attr_reader :rain

  @@imminent   = (0..4).to_a.map {|e| e*6}
  @@warning    = (5..8).to_a.map {|e| e*6}
  @@watch      = (9..28).to_a.map {|e| e*6}

  def initialize(site, forecast)
    @site = site
    @forecast = forecast
  end

  def find_rain_chance(pop = 50, interval = 6)
    index = @forecast[0].map.with_index do |f,i|
      (f.to_i >= pop) ? i : nil
    end
    # compact return a copy of the array with nil elements removed
    forecast = index.compact.map { |e| e*6 }
    set_rain_state(forecast)
    add_report
    mail_alert
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

  # TODO: fire events to listeners
  def add_report
    # TODO: should traverse listener queue for conditions and callbacks
    if @rain == :warning or @rain == :imminent
      @site.reports.create
    end
  end

  def mail_alert
    if @rain == :warning or @rain == :imminent
      AlertMailer.pop_alert(@user)
    end
  end

end
