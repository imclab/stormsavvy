require 'typhoeus'
require 'nokogiri'
require 'geocoder'
require 'date'
require 'time'
require 'project_local_time'
require 'redis'

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
    @duration = 168
    @interval = 6

    if return_lat_long(@zipcode) == nil
      latlong = get_lat_long(@zipcode)
    else
      latlong = return_lat_long(@zipcode)
    end

    return get_forecast(latlong)

    # previous call using get_lat_long only
    # latlong = get_lat_long(@zipcode)
    # return get_forecast(latlong)
  end

  def get_lat_long(zipcode)
    results = Geocoder.search(zipcode)
    # TODO: Factor out this ugly thing into a Google result getter.
    return [] << results[0].data["geometry"]["location"]["lat"] << results[0].data["geometry"]["location"]["lng"] #yuck
=begin
    # Comment back once all spec run locally
    @lat = results[0].data["geometry"]["location"]["lat"]
    @lng = results[0].data["geometry"]["location"]["lng"]
    lat_long = [] << @lat << @lng
    return lat_long
=end
  end

  def set_lat_long(zipcode)
    $redis.set(zipcode.to_s + '_lat', lat_long[0])
    $redis.set(zipcode.to_s + '_long', lat_long[1])
  end

  def return_lat_long(zipcode)
    lat_long = {
      :zipcode_lat => $redis.get(zipcode.to_s + '_lat'),
      :zipcode_long => $redis.get(zipcode.to_s + '_long')
    }
    return lat_long 
  end

  def get_forecast(latlong)
    response = ping_noaa(latlong, @duration, @interval)
    return parse_weather_data(response)
  end

  def get_time_array
=begin
    nf = NOAAForecast.new(94530,168,6)
    pop.each_with_index do |(i, p), index|
      pt << { ProjectLocalTime::format(Date.today + (index*6).hours) => i } << { nf.seven_day_weather => p }
    end
=end
    pt = []
    pop.each_with_index do |(i, p), index|
      pt << { :date => ProjectLocalTime::format(Date.today + (index*6).hours), :weather => i  }
    end
  end

  def get_forecast_array
    nf = NOAAForecast.new(94530,168,6)
    pop = nf.seven_day_weather
    [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0][0], :rainfall => pop[1][0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[0][1], :rainfall => pop[1][1] },
      { :date => ProjectLocalTime::format(Date.today + 12.hours), :weather => pop[0][2], :rainfall => pop[1][2] },
      { :date => ProjectLocalTime::format(Date.today + 18.hours), :weather => pop[0][3], :rainfall => pop[1][3] },
      { :date => ProjectLocalTime::format(Date.today + 24.hours), :weather => pop[0][4], :rainfall => pop[1][4] },
      { :date => ProjectLocalTime::format(Date.today + 30.hours), :weather => pop[0][5], :rainfall => pop[1][5] },
      { :date => ProjectLocalTime::format(Date.today + 36.hours), :weather => pop[0][6], :rainfall => pop[1][6] },
      { :date => ProjectLocalTime::format(Date.today + 42.hours), :weather => pop[0][7], :rainfall => pop[1][7] },
      { :date => ProjectLocalTime::format(Date.today + 48.hours), :weather => pop[0][8], :rainfall => pop[1][8] },
      { :date => ProjectLocalTime::format(Date.today + 54.hours), :weather => pop[0][9], :rainfall => pop[1][9] },
      { :date => ProjectLocalTime::format(Date.today + 60.hours), :weather => pop[0][10], :rainfall => pop[1][10] },
      { :date => ProjectLocalTime::format(Date.today + 66.hours), :weather => pop[0][11], :rainfall => pop[1][11] },
      { :date => ProjectLocalTime::format(Date.today + 72.hours), :weather => pop[0][12], :rainfall => pop[1][12] },
      { :date => ProjectLocalTime::format(Date.today + 78.hours), :weather => pop[0][13], :rainfall => pop[1][13] },
      { :date => ProjectLocalTime::format(Date.today + 84.hours), :weather => pop[0][14], :rainfall => pop[1][14] },
      { :date => ProjectLocalTime::format(Date.today + 90.hours), :weather => pop[0][15], :rainfall => pop[1][15] },
      { :date => ProjectLocalTime::format(Date.today + 96.hours), :weather => pop[0][16], :rainfall => pop[1][16] },
      { :date => ProjectLocalTime::format(Date.today + 102.hours), :weather => pop[0][17], :rainfall => pop[1][17] },
      { :date => ProjectLocalTime::format(Date.today + 108.hours), :weather => pop[0][18], :rainfall => pop[1][18] },
      { :date => ProjectLocalTime::format(Date.today + 114.hours), :weather => pop[0][19], :rainfall => pop[1][19] },
      { :date => ProjectLocalTime::format(Date.today + 120.hours), :weather => pop[0][20], :rainfall => pop[1][20] },
      { :date => ProjectLocalTime::format(Date.today + 126.hours), :weather => pop[0][21], :rainfall => pop[1][21] },
      { :date => ProjectLocalTime::format(Date.today + 132.hours), :weather => pop[0][22], :rainfall => pop[1][22] },
      { :date => ProjectLocalTime::format(Date.today + 138.hours), :weather => pop[0][23], :rainfall => pop[1][23] },
      { :date => ProjectLocalTime::format(Date.today + 144.hours), :weather => pop[0][24], :rainfall => pop[1][24] },
      { :date => ProjectLocalTime::format(Date.today + 150.hours), :weather => pop[0][25], :rainfall => pop[1][25] },
      { :date => ProjectLocalTime::format(Date.today + 156.hours), :weather => pop[0][26], :rainfall => pop[1][26] },
      { :date => ProjectLocalTime::format(Date.today + 162.hours), :weather => pop[0][27], :rainfall => pop[1][27] },
      { :date => ProjectLocalTime::format(Date.today + 168.hours), :weather => pop[0][28], :rainfall => pop[1][28] }
    ]
  end

  def forecast_by_zipcode(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    pop = nf.seven_day_weather
    [
      { :date => ProjectLocalTime::format(Date.today), :weather => pop[0][0], :rainfall => pop[1][0] },
      { :date => ProjectLocalTime::format(Date.today + 6.hours), :weather => pop[0][1], :rainfall => pop[1][1] },
      { :date => ProjectLocalTime::format(Date.today + 12.hours), :weather => pop[0][2], :rainfall => pop[1][2] },
      { :date => ProjectLocalTime::format(Date.today + 18.hours), :weather => pop[0][3], :rainfall => pop[1][3] },
      { :date => ProjectLocalTime::format(Date.today + 24.hours), :weather => pop[0][4], :rainfall => pop[1][4] },
      { :date => ProjectLocalTime::format(Date.today + 30.hours), :weather => pop[0][5], :rainfall => pop[1][5] },
      { :date => ProjectLocalTime::format(Date.today + 36.hours), :weather => pop[0][6], :rainfall => pop[1][6] },
      { :date => ProjectLocalTime::format(Date.today + 42.hours), :weather => pop[0][7], :rainfall => pop[1][7] },
      { :date => ProjectLocalTime::format(Date.today + 48.hours), :weather => pop[0][8], :rainfall => pop[1][8] },
      { :date => ProjectLocalTime::format(Date.today + 54.hours), :weather => pop[0][9], :rainfall => pop[1][9] },
      { :date => ProjectLocalTime::format(Date.today + 60.hours), :weather => pop[0][10], :rainfall => pop[1][10] },
      { :date => ProjectLocalTime::format(Date.today + 66.hours), :weather => pop[0][11], :rainfall => pop[1][11] },
      { :date => ProjectLocalTime::format(Date.today + 72.hours), :weather => pop[0][12], :rainfall => pop[1][12] },
      { :date => ProjectLocalTime::format(Date.today + 78.hours), :weather => pop[0][13], :rainfall => pop[1][13] },
      { :date => ProjectLocalTime::format(Date.today + 84.hours), :weather => pop[0][14], :rainfall => pop[1][14] },
      { :date => ProjectLocalTime::format(Date.today + 90.hours), :weather => pop[0][15], :rainfall => pop[1][15] },
      { :date => ProjectLocalTime::format(Date.today + 96.hours), :weather => pop[0][16], :rainfall => pop[1][16] },
      { :date => ProjectLocalTime::format(Date.today + 102.hours), :weather => pop[0][17], :rainfall => pop[1][17] },
      { :date => ProjectLocalTime::format(Date.today + 108.hours), :weather => pop[0][18], :rainfall => pop[1][18] },
      { :date => ProjectLocalTime::format(Date.today + 114.hours), :weather => pop[0][19], :rainfall => pop[1][19] },
      { :date => ProjectLocalTime::format(Date.today + 120.hours), :weather => pop[0][20], :rainfall => pop[1][20] },
      { :date => ProjectLocalTime::format(Date.today + 126.hours), :weather => pop[0][21], :rainfall => pop[1][21] },
      { :date => ProjectLocalTime::format(Date.today + 132.hours), :weather => pop[0][22], :rainfall => pop[1][22] },
      { :date => ProjectLocalTime::format(Date.today + 138.hours), :weather => pop[0][23], :rainfall => pop[1][23] },
      { :date => ProjectLocalTime::format(Date.today + 144.hours), :weather => pop[0][24], :rainfall => pop[1][24] },
      { :date => ProjectLocalTime::format(Date.today + 150.hours), :weather => pop[0][25], :rainfall => pop[1][25] },
      { :date => ProjectLocalTime::format(Date.today + 156.hours), :weather => pop[0][26], :rainfall => pop[1][26] },
      { :date => ProjectLocalTime::format(Date.today + 162.hours), :weather => pop[0][27], :rainfall => pop[1][27] },
      { :date => ProjectLocalTime::format(Date.today + 168.hours), :weather => pop[0][28], :rainfall => pop[1][28] }
    ]
  end

  def ping_noaa(latlong, duration, interval)
    # xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=168&interval=6&lat=38.2473117&lon=-122.5712101"
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
