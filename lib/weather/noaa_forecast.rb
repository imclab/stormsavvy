require 'typhoeus'
require 'nokogiri'
require 'geocoder'

class NOAAForecast

  include Typhoeus
  include Nokogiri

  attr_reader :noaa_forecast

  def initialize(zipcode, duration = 168, interval = 6)
    @zipcode  = zipcode
    @duration = duration
    @interval = interval
  end

  def seven_day_temp(zipcode)
    latlong = get_lat_long(zipcode)
    response = ping_noaa(latlong, 168, 6)
    get_weather_data(response.body)
  end

  def get_lat_long(zipcode)
    results = Geocoder.search(zipcode)
    # TODO: Factor out this ugly thing into a Google result getter.
    return [] << results[0].data["geometry"]["location"]["lat"] << results[0].data["geometry"]["location"]["lng"] #yuck
  end

  def ping_noaa(latlong, duration, interval)
    xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=#{duration}&interval=#{interval}&lat=#{latlong[0]}&lon=#{latlong[1]}"
    request = Typhoeus::Request.new(xml,
              :body          => "this is a request body",
              :method        => :post,
              :headers       => {:Accept => "text/html"},
              :timeout       => 2000, # milliseconds
              :cache_timeout => 60, # seconds
              :params        => {:field1 => "a field"})
    hydra = Typhoeus::Hydra.new
    hydra.queue(request)
    hydra.run
    response = request.response
  end

  def get_weather_data(xmldoc)
    doc   = Nokogiri::XML(xmldoc)
    pop = doc.xpath("//pop").map { |n| n.content.to_i }
    qpf = doc.xpath("//qpf").map { |n| n.content.to_i }
    @noaa_forecast =  [] << pop << qpf
  end

end
