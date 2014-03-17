require 'typhoeus'
require 'nokogiri'
require 'geocoder'
require 'date'
require 'time'
require 'project_local_time'

class ApiError < StandardError
end

class NOAAForecast

  include Typhoeus
  include Nokogiri

  attr_reader :pop, :qpf

  def initialize(zipcode, duration = 168, interval = 6)
    @zipcode  = zipcode
    @duration = duration
    @interval = interval
  end

  def seven_day_weather(zipcode)
    latlong = get_lat_long(zipcode)
    return get_forecast(latlong)
  end

  def get_lat_long(zipcode)
    begin
      service = GeocoderService.new(zipcode: zipcode)
      results = service.get_lat_lng
      @lat = results[:lat]
      @long = results[:long]
      lat_long = [] << @lat << @lng
      return lat_long
    rescue => e
    end

    # user geocoderservice instead, which includes geocoder
    # results = Geocoder.search(zipcode)
    # @lat = results[0].data["geometry"]["location"]["lat"]
    # @lng = results[0].data["geometry"]["location"]["lng"]
    # lat_long = [] << @lat << @lng
    # return lat_long
  end

  def get_forecast(latlong)
    response = ping_noaa(latlong, @duration, @interval)
    return parse_weather_data(response)
  end

  def ping_noaa(latlong, duration, interval)
    # pp 'sleep for 2s between queries'
    # sleep(2)

    xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=#{duration}&interval=#{interval}&lat=#{latlong[0]}&lon=#{latlong[1]}"
    request = Typhoeus::Request.new(xml,
      body: "this is a request body",
      method: :post,
      headers: {:Accept => "text/html"},
      timeout: 5000, # milliseconds
      # cache_timeout: 60, # seconds
      params: {:field1 => "a field"}
    )
    hydra = Typhoeus::Hydra.new
    hydra.queue(request)
    hydra.run
    request.response.body
  end

  def log_response(request)
    request.on_complete do |response|
      if response.success?
        pp 'response successful'
        log('response successful')
      elsif response.timed_out?
        pp 'response timed out'
        log("response timed out")
      elsif response.code == 0
        pp 'an error occurred, check logs'
        log(response.return_message)
      else
        pp 'non-successful http response'
        log("HTTP request failed: " + response.code.to_s)
      end
    end
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
    noaa_forecast
  end

  def get_pop(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    nf.seven_day_weather(zipcode)
    pop = nf.pop
  end

  def get_qpf(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    nf.seven_day_weather(zipcode)
    qpf = nf.qpf
  end

  def get_time_array
    time_array = []
    for t in (0..27)
      time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
    end
    return time_array
  end

  def get_pop_array(zipcode)
    pop_array = get_pop(zipcode)
    new_pop_array = []
    pop_array.each do |i|
      new_pop_array << { :weather => pop_array[i].to_s }
    end
    return new_pop_array
  end

  def get_qpf_array(zipcode)
    qpf_array = get_qpf(zipcode)
    new_qpf_array = []
    qpf_array.each do |i|
      new_qpf_array << { :rainfall => qpf_array[i].to_s }
    end
    return new_qpf_array
  end

  def get_time_pop_hash(zipcode)
    nf = NOAAForecast.new(zipcode)
    time_array = nf.get_time_array
    new_pop_array = nf.get_pop_array(zipcode)

    time_pop_hash = []
    for i in (0..27)
      time_pop_hash << time_array[i].update(new_pop_array[i])
    end
    return time_pop_hash
  end

  def get_pop_table_hash(zipcode)
    nf = NOAAForecast.new(zipcode)
    time_pop_hash = nf.get_time_pop_hash(zipcode)
    new_qpf_array = nf.get_qpf_array(zipcode)

    pop_table_hash = []
    for i in (0..27)
      pop_table_hash << time_pop_hash[i].merge!(new_qpf_array[i])
    end
    return pop_table_hash
  end

  def get_forecast_array(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    pop = nf.seven_day_weather(zipcode)

    forecast_array = []
    for i in (0..27)
      date = { :date => ProjectLocalTime::format(Date.today + (6*i).hours) }
      weather = { :weather => pop[0][i] }
      rainfall = { :rainfall => pop[1][i] }

      date_weather = date.merge!(weather)
      date_weather_rainfall = date_weather.merge!(rainfall)
      forecast_array.push(date_weather_rainfall)
    end
    return forecast_array
  end

  #alias ProjectLocalTime PLT
  def forecast_by_zipcode(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    pop = nf.seven_day_weather(zipcode)

    forecast_array = []
    for i in (0..27)
      date = { :date => ProjectLocalTime::format(Date.today + (6*i).hours) }
      weather = { :weather => pop[0][i] }
      rainfall = { :rainfall => pop[1][i] }

      date_weather = date.merge!(weather)
      date_weather_rainfall = date_weather.merge!(rainfall)
      forecast_array.push(date_weather_rainfall)
    end
    return forecast_array
  end
end
