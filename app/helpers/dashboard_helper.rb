module DashboardHelper

include Typhoeus

  def current_weather
    xml = "http://www.wrh.noaa.gov/forecast/xml/xml.php?duration=168&interval=6&lat=37.92021&lon=-122.29374"
    table = "http://www.wrh.noaa.gov/forecast/wxtables/index.php?lat=38.4373944&lon=-123.0620193&clrindex=0&table=custom&duration=7&interval=6"
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
  end

end
