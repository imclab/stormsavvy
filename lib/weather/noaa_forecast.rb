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
    #@duration = 168
    #@interval = 6
    latlong = get_lat_long(zipcode)
    return get_forecast(latlong)
  end

  def get_lat_long(zipcode)
    lat_long ||= Rails.cache.fetch(@zipcode.to_s + '_lat_long', expires_in: 24.hours) do
      unless lat_long == [nil, nil]
        begin
          results = Geocoder.search(zipcode)
          @lat = results[0].data["geometry"]["location"]["lat"]
          @lng = results[0].data["geometry"]["location"]["lng"]
          lat_long = [] << @lat << @lng

          Rails.cache.fetch(zipcode.to_s + '_lat_long', expires_in: 24.hours) { lat_long }
        rescue Exception => e
          nil
        end
      end
    end

    lat_long = [] << @lat << @lng
    return lat_long
  end

  def get_forecast(latlong)
    response = ping_noaa(latlong, @duration, @interval)
    return parse_weather_data(response)
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
    for t in 0..27
      time_array << { :date => ProjectLocalTime::format(Date.today + (t*6).hours) }
    end

    return time_array
  end

  def get_pop_array(zipcode)
    pop_array = get_pop(zipcode)
    # nf = NOAAForecast.new(94530,168,6)
    # nf.seven_day_weather
    # pop_array = nf.pop
    new_pop_array = []
    pop_array.each do |i|
      new_pop_array << { :weather => pop_array[i].to_s }
    end
    return new_pop_array
  end

  def get_qpf_array(zipcode)
    qpf_array = get_qpf(zipcode)
    # nf = NOAAForecast.new(94530,168,6)
    # nf.seven_day_weather
    # qpf_array = nf.qpf
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

    # refactor into proper loop
    time_pop_hash = [
      time_array[0].update(new_pop_array[0]),
      time_array[1].update(new_pop_array[1]),
      time_array[2].update(new_pop_array[2]),
      time_array[3].update(new_pop_array[3]),
      time_array[4].update(new_pop_array[4]),
      time_array[5].update(new_pop_array[5]),
      time_array[6].update(new_pop_array[6]),
      time_array[7].update(new_pop_array[7]),
      time_array[8].update(new_pop_array[8]),
      time_array[9].update(new_pop_array[9]),
      time_array[10].update(new_pop_array[10]),
      time_array[11].update(new_pop_array[11]),
      time_array[12].update(new_pop_array[12]),
      time_array[13].update(new_pop_array[13]),
      time_array[14].update(new_pop_array[14]),
      time_array[15].update(new_pop_array[15]),
      time_array[16].update(new_pop_array[16]),
      time_array[17].update(new_pop_array[17]),
      time_array[18].update(new_pop_array[18]),
      time_array[19].update(new_pop_array[19]),
      time_array[20].update(new_pop_array[20]),
      time_array[21].update(new_pop_array[21]),
      time_array[22].update(new_pop_array[22]),
      time_array[23].update(new_pop_array[23]),
      time_array[24].update(new_pop_array[24]),
      time_array[25].update(new_pop_array[25]),
      time_array[26].update(new_pop_array[26]),
      time_array[27].update(new_pop_array[27])
    ]
  end

  def get_pop_table_hash(zipcode)
    nf = NOAAForecast.new(zipcode)
    time_pop_hash = nf.get_time_pop_hash(zipcode)
    new_qpf_array = nf.get_qpf_array(zipcode)

    # refactor into proper loop
    # pop_table_hash.each_index do |i|
    #   time_pop_hash[i+1].update(new_qpf_array[i+1]),
    # end

    pop_table_hash = [
      time_pop_hash[1].update(new_qpf_array[1]),
      time_pop_hash[2].update(new_qpf_array[2]),
      time_pop_hash[3].update(new_qpf_array[3]),
      time_pop_hash[4].update(new_qpf_array[4]),
      time_pop_hash[5].update(new_qpf_array[5]),
      time_pop_hash[6].update(new_qpf_array[6]),
      time_pop_hash[7].update(new_qpf_array[7]),
      time_pop_hash[8].update(new_qpf_array[8]),
      time_pop_hash[9].update(new_qpf_array[9]),
      time_pop_hash[10].update(new_qpf_array[10]),
      time_pop_hash[11].update(new_qpf_array[11]),
      time_pop_hash[12].update(new_qpf_array[12]),
      time_pop_hash[13].update(new_qpf_array[13]),
      time_pop_hash[14].update(new_qpf_array[14]),
      time_pop_hash[15].update(new_qpf_array[15]),
      time_pop_hash[16].update(new_qpf_array[16]),
      time_pop_hash[17].update(new_qpf_array[17]),
      time_pop_hash[18].update(new_qpf_array[18]),
      time_pop_hash[19].update(new_qpf_array[19]),
      time_pop_hash[20].update(new_qpf_array[20]),
      time_pop_hash[21].update(new_qpf_array[21]),
      time_pop_hash[22].update(new_qpf_array[22]),
      time_pop_hash[23].update(new_qpf_array[23]),
      time_pop_hash[24].update(new_qpf_array[24]),
      time_pop_hash[25].update(new_qpf_array[25]),
      time_pop_hash[26].update(new_qpf_array[26]),
      time_pop_hash[27].update(new_qpf_array[27])
    ]
  end

  # def get_pt_hash
  #   nf = NOAAForecast.new(94530,168,6)
  #   nf.seven_day_weather(zipcode)
  #   pop = nf.pop
  #   pt = []
  #   pop.each do |i|
  #     pt << { :date => ProjectLocalTime::format(Date.today + (i*6).hours), :weather => i.to_s }
  #   end
  #   return pt
  # end

  def get_forecast_array(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    pop = nf.seven_day_weather(zipcode)
    [
      { :date => ProjectLocalTime::format(Date.today + 0.hours), :weather => pop[0][0], :rainfall => pop[1][0] },
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

  #alias ProjectLocalTime PLT
  def forecast_by_zipcode(zipcode)
    nf = NOAAForecast.new(zipcode,168,6)
    pop = nf.seven_day_weather(zipcode)
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
    request.response.body
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
end
