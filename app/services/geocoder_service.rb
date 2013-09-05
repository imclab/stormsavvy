class GeocoderService

  def initialize(opts = {})
    @zipcode = opts[:zipcode]
  end

  def get_lat_lng
    @results ||= run_geocoder
  end

  private

  def run_geocoder
    if google_geocoder_lookup == [0.0, 0.0] || []
      geoname_geocoder_lookup
      return_results_hash
    else
      return_results_hash
    end
  end

  def google_geocoder_lookup
    results = Geocoder.search(@zipcode).presence || NullGoogleGeocoder.new.results
    result = results[0].data["geometry"]["location"]
    @lat, @lng = result["lat"], result["lng"]
  end

  def geoname_geocoder_lookup
    results = GeonamesGeocodingService.search(@zipcode).presence || NullGeonamesGeocoder.new.results
    result = results.body["postalCodes"][0]
    @lat, @lng = result["lat"], result["lng"]
  end

  def return_results_hash
    { lat: @lat, lng: @lng }
  end

end

class NullGoogleGeocoder
  def initialize; end
  def results
    [ OpenStruct.new({ data: { "geometry" => { "location" => { "lat" => 0.0, "lng" => 0.0 } } } }) ]
  end
end

class NullGeonamesGeocoder
  def initialize; end
  def results
    data = { "adminName2"=>"Empty", "adminCode2"=>"Empty", "adminCode1"=>"Empty", "postalCode"=>"Empty", "countryCode"=>"Empty", "lng"=> 0.0, "placeName"=>"Empty", "lat"=> 0.0, "adminName1"=>"Empty"}
    OpenStruct.new({ body: { "postalCodes"=> [ data ] } } )
  end
end