require 'typhoeus'
require 'nokogiri'
require 'geocoder'

class NOAAForecast

  include Typhoeus
  include Nokogiri

  attr_reader :noaa_forecast
  attr_reader :zipcode

  def initialize(zipcode, duration = 168, interval = 6)
    @zipcode  = zipcode
    @duration = duration
    @interval = interval
  end

  def seven_day_weather
    latlong = get_lat_long
    response = ping_noaa(latlong, 168, 6)
    get_weather_data(response.body)
  end

  def get_lat_long
    results = Geocoder.search(@zipcode)
    # TODO: Factor out this ugly thing into a Google result getter.
    return [] << results[0].data["geometry"]["location"]["lat"] << results[0].data["geometry"]["location"]["lng"] #yuck
  end

  def forecast(lat, long)
    latlong = [] << lat << long  
    response = ping_noaa(latlong, 168, 6)
    get_weather_data(response.body)
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

=begin
  def self.get_noaa_pop_data

    hydra = Typhoeus::Hydra.new

    self.all.each do |s|
      latlng = "#{s.lat}%2C#{s.long}"
      begin_time = (Time.now + 22.hours).xmlschema
      end_time = (Time.now + 26.hours).xmlschema
      #binding.pry
      url = "http://graphical.weather.gov/xml/SOAP_server/ndfdXMLclient.php?whichClient=GmlLatLonList&lat=&lon=&listLatLon=&lat1=&lon1=&lat2=&lon2=&resolutionSub=&listLat1=&listLon1=&listLat2=&listLon2=&resolutionList=&endPoint1Lat=&endPoint1Lon=&endPoint2Lat=&endPoint2Lon=&listEndPoint1Lat=&listEndPoint1Lon=&listEndPoint2Lat=&listEndPoint2Lon=&zipCodeList=&listZipCodeList=&centerPointLat=&centerPointLon=&distanceLat=&distanceLon=&resolutionSquare=&listCenterPointLat=&listCenterPointLon=&listDistanceLat=&listDistanceLon=&listResolutionSquare=&citiesLevel=&listCitiesLevel=&sector=&gmlListLatLon=#{latlng}&featureType=Forecast_Gml2Point&requestedTime=&startTime=&endTime=&compType=&propertyName=&product=time-series&begin=#{begin_time}&end=#{end_time}&Unit=e&pop12=pop12&Submit=Submit"

      request = Typhoeus::Request.new(url)
      hydra.queue(request)

      request.on_complete do |response|
        xml = response.body
        noko = Nokogiri::XML(xml)
        pop24 = noko.xpath("//app:probOfPrecip12hourly").text
        datetime = noko.xpath("//app:validTime").text

        # Save noaa data to db
        sitepop = SitePop.create!(:date => datetime, :pop => pop24, :site => s)

        # Create report if needed
        if pop24.to_i > 25
          puts "Site #{s.name} hit 25% threshold"
          r = Report.new
          r.site_id = s.id
          r.status = "needs_attention"
          r.save
        end
      end
    end

    # run all queued processes
    puts "Sending requests to noaa"
    hydra.run

  end
#=end

  def weather_trigger?(trigger_level = 50, time_ahead = 24.hours)  
    pop_point = self.get_pop_at_point(time_ahead)
    if pop_point
      pop_point.pop >= trigger_level
    else
      return "No data found"
    end
  end

  def get_pop_at_point(time_ahead = 24.hours, granularity = 6.hours)
    time_ahead_point = Time.now + time_ahead
    record = self.site_pop.where("date > ? AND date <= ?", time_ahead_point - granularity / 2, time_ahead_point + granularity / 2).first
  end

  def current_pop
    current_pop = self.site_pop.order("date ASC").where("date >= ?", Time.now).first
    if current_pop
      return current_pop.pop
    else
      return "N/A"
    end
  end
=end

end
