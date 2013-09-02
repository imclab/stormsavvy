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
      cloudmade_geocoder_lookup
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

  def cloudmade_geocoder_lookup
    results = CloudmadeGeocodingService.search(@zipcode).presence || NullCloudmadeGeocoder.new.results
    result = results.body["places"][0]["position"]
    @lat, @lng = result["lat"], result["lon"]
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

class NullCloudmadeGeocoder
  def initialize; end
  def results
    OpenStruct.new( { body: { "places" => [ "position" => { "lat" => 0.0, "lon" => 0.0 } ] } } )
    # [position: {}]
  end
end