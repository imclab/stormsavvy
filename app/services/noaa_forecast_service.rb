class NoaaForecastService

  API_URL = "http://www.wrh.noaa.gov/forecast/xml/xml.php?"

  def initialize( opts = {} )
    @site = opts[:site]
    @lat = @site.lat
    @lng = @site.lng
    @duration = opts[:duration] || 168
    @interval = opts[:interval] || 3
  end

  def get_forecast
    @response ||= fetch_noaa_data
  end

  private

  def fetch_noaa_data
    contact_noaa
    process_xml_response
    # process_weather_update
    process_forecast_periods
  end

  def contact_noaa
    url = "#{API_URL}duration=#{@duration}&interval=#{@interval}&lat=#{@lat}&lon=#{@lng}"
    puts url
    @response = Unirest::get(url)
  end

  def process_xml_response
    @xml = Nokogiri::XML(@response.body)
  end

  def process_weather_update
    @weather_update = @site.weather_updates.new
    @weather_update.build_from_xml(@xml)
    @weather_update.save!
  end

  def process_forecast_periods
    forecast_days = @xml.xpath("//forecastDay")
    forecast_days.each do |forecast_day|
      parse_forecase_day(forecast_day)
    end
  end

  def parse_forecase_day(forecast_day)
    validDate = Date.parse(forecast_day.xpath("validDate").text)
    forecast_day.xpath("period").each do |period|
      puts parse_period(period, validDate)
    end
  end

  def parse_period(period, validDate)
    validTime = period.xpath("validTime").text
    fullTime = DateTime.parse "#{validDate} #{validTime}"
    temperature = period.xpath("temperature").text
    dewpoint = period.xpath("dewpoint").text
    rh = period.xpath("rh").text
    skyCover = period.xpath("skyCover").text
    windSpeed = period.xpath("windSpeed").text
    windDirection = period.xpath("windDirection").text
    windGust = period.xpath("windGust").text
    pop = period.xpath("pop").text
    qpf = period.xpath("qpf").text
    snowAmt = period.xpath("snowAmt").text
    snowLevel = period.xpath("snowLevel").text
    wx = period.xpath("wx").text
    data = {forecast_prediction_time: fullTime, temperature: temperature, dewpoint: dewpoint, rh: rh, sky_cover: skyCover, wind_speed: windSpeed, wind_direction: windDirection, wind_gust: windGust, pop: pop, qpf: qpf, snow_amount: snowAmt, snow_level: snowLevel, wx: wx}
    return data
  end

end