class CloudmadeGeocodingService
  API_KEY = "0a3277fb44be4f509256d82e7f78f48a"
  API_URL = "http://beta.geocoding.cloudmade.com/v3/#{API_KEY}/api/geo.location.search.2?"

  def self.search(zipcode)
    result ||= Unirest::get("#{API_URL}format=json&source=OSM&enc=UTF-8&limit=10&locale=us&q=#{zipcode}")
  end


end