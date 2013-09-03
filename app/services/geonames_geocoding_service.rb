class GeonamesGeocodingService
  USER_NAME = "stormsavvy"
  API_URL = "http://api.geonames.org/postalCodeSearchJSON?&maxRows=1&username=#{USER_NAME}&countryBias=US"

  def self.search(zipcode)
    url = "#{API_URL}&postalcode=#{zipcode}"
    puts url
    result ||= Unirest::get(url)
  end


end