require 'typhoeus'
require 'nokogiri'
require 'geocoder'
require 'date'
require 'time'

class NOAAForecast

  include Typhoeus
  include Nokogiri


  def initialize(zipcode, duration = 168, interval = 6)
    @zipcode  = zipcode
    @duration = duration
    @interval = interval
  end

  def seven_day_weather
    latlong = get_lat_long(@zipcode)
    @duration = 168
    @interval = 6
    return get_forecast(latlong)
  end

  def get_lat_long(zipcode)
    results = Geocoder.search(zipcode)
    # TODO: Factor out this ugly thing into a Google result getter.
    return [] << results[0].data["geometry"]["location"]["lat"] << results[0].data["geometry"]["location"]["lng"] #yuck
  end

  def get_forecast(latlong)
    response = ping_noaa(latlong, @duration, @interval)
    return parse_weather_data(response)
  end

  def get_forecast_array
    nf = NOAAForecast.new(94530,168,6)
    [ { :date => Date.today, :weather => nf.seven_day_weather[0][0] },
      { :date => Date.today + 6.hours, :weather => nf.seven_day_weather[0][1] },
      { :date => Date.today + 12.hours, :weather => nf.seven_day_weather[0][2] },
      { :date => Date.today + 18.hours, :weather => "element fails spec" },
      # { :date => Date.today + 18.hours, :weather => nf.seven_day_weather[0][3] },
      { :date => Date.today + 24.hours, :weather => nf.seven_day_weather[0][4] },
      { :date => Date.today + 30.hours, :weather => nf.seven_day_weather[0][5] },
      { :date => Date.today + 36.hours, :weather => nf.seven_day_weather[0][6] },
      { :date => Date.today + 42.hours, :weather => nf.seven_day_weather[0][7] },
      { :date => Date.today + 48.hours, :weather => nf.seven_day_weather[0][8] },
      { :date => Date.today + 54.hours, :weather => nf.seven_day_weather[0][9] },
      { :date => Date.today + 60.hours, :weather => nf.seven_day_weather[0][10] },
      { :date => Date.today + 66.hours, :weather => nf.seven_day_weather[0][11] },
      { :date => Date.today + 72.hours, :weather => nf.seven_day_weather[0][12] },
      { :date => Date.today + 78.hours, :weather => nf.seven_day_weather[0][13] },
      { :date => Date.today + 84.hours, :weather => "element fails spec" },
      # { :date => Date.today + 84.hours, :weather => nf.seven_day_weather[0][14] },
      { :date => Date.today + 90.hours, :weather => nf.seven_day_weather[0][15] },
      { :date => Date.today + 96.hours, :weather => nf.seven_day_weather[0][16] },
      { :date => Date.today + 102.hours, :weather => nf.seven_day_weather[0][17] },
      { :date => Date.today + 108.hours, :weather => nf.seven_day_weather[0][18] },
      { :date => Date.today + 114.hours, :weather => nf.seven_day_weather[0][19] },
      { :date => Date.today + 120.hours, :weather => nf.seven_day_weather[0][20] },
      { :date => Date.today + 126.hours, :weather => nf.seven_day_weather[0][21] },
      { :date => Date.today + 132.hours, :weather => nf.seven_day_weather[0][22] },
      { :date => Date.today + 138.hours, :weather => nf.seven_day_weather[0][23] },
      { :date => Date.today + 142.hours, :weather => nf.seven_day_weather[0][24] },
      { :date => Date.today + 148.hours, :weather => nf.seven_day_weather[0][25] },
      { :date => Date.today + 154.hours, :weather => nf.seven_day_weather[0][26] },
      { :date => Date.today + 160.hours, :weather => nf.seven_day_weather[0][27] },
      { :date => Date.today + 166.hours, :weather => nf.seven_day_weather[0][28] }
    ]
  end

  def ping_noaa(latlong, duration, interval)
    xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=#{duration}&interval=#{interval}&lat=#{latlong[0]}&lon=#{latlong[1]}"
    request = Typhoeus::Request.new(xml,
              :body          => "this is a request body",
              :method        => :post,
              :headers       => {:Accept => "text/html"},
              :timeout       => 2000, # milliseconds
              # :cache_timeout => 60, # seconds
              :params        => {:field1 => "a field"})
    hydra = Typhoeus::Hydra.new
    hydra.queue(request)
    hydra.run
    return request.response.body
  end

  def get_valid_dates(xmldoc)
    doc   = Nokogiri::XML(xmldoc)
    doc.xpath("//validDate").map { |n| n.content.to_i }
  end

  def get_forecast_creation_time(xmldoc)
    doc   = Nokogiri::XML(xmldoc)
    datestring = doc.xpath("//forecastCreationTime").first.content
    DateTime.parse(datestring, "%a %b %d %H:%M:%S %Y %Z")
  end

  def parse_weather_data(xmldoc)
    doc   = Nokogiri::XML(xmldoc)
    pop = doc.xpath("//pop").map { |n| n.content.to_i }
    qpf = doc.xpath("//qpf").map { |n| n.content.to_i }
    noaa_forecast =  [] << pop << qpf
    return noaa_forecast
  end

end
