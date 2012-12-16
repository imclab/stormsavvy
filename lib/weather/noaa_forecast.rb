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
