module DashboardHelper

include Typhoeus
include Nokogiri

  def seven_day_temp(zipcode)

    #l = Location.where(:zipcode => zipcode).first
    #xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=168&interval=6&lat=#{l.lat}&lon=#{l.long}"
    ll = Location::latlong(zipcode.to_i)
    xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=168&interval=6&lat=#{ll[0]}&lon=#{ll[1]}"
#=begin    
    
    #table = "http://www.wrh.noaa.gov/forecast/wxtables/index.php?lat=#{l.lat}&lon=#{l.long}&clrindex=0&table=custom&duration=7&interval=6"
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
    hydra.queue(request)
    hydra.run
    response = request.response
    doc   = Nokogiri::XML(response.body)
    #binding.pry
    return doc.xpath("//temperature").map { |n| n.content.to_i }
#=end
  end
end
