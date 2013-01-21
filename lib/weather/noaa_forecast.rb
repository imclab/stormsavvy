require 'typhoeus'
require 'nokogiri'
require 'geocoder'
require 'date'
require 'time'
require 'project_local_time'

class NOAAForecast

  include Typhoeus
  include Nokogiri

  attr_reader :pop, :qpf

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

  def get_time_array
    nf = NOAAForecast.new(94530,168,6)
    pt = []
=begin
    pop.each_with_index do |(i, p), index|
      pt << { ProjectLocalTime::format(Date.today + (index*6).hours) => i } << { nf.seven_day_weather => p }
    end
=end
    pop.each_with_index do |(i, p), index|
      pt << { :date => ProjectLocalTime::format(Date.today + (index*6).hours), :weather => i  }
    end
  end

  def get_forecast_array
    nf = NOAAForecast.new(94530,168,6)
    pop = nf.seven_day_weather
    [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0][0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[0][1] }
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
    @pop = doc.xpath("//pop").map { |n| n.content.to_i }
    @qpf = doc.xpath("//qpf").map { |n| n.content.to_i }
    noaa_forecast =  [] << @pop << @qpf
    return noaa_forecast
  end

end
