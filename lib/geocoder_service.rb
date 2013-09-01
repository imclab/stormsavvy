class GeocoderService

  def initialize(opts = {})
    @zipcode = opts[:zipcode]
  end

  def get_lat_lng
    @results ||= run_geocoder
  end

  private

  def run_geocoder
    google_geocoder_lookup
    return_results_hash
  end

  def google_geocoder_lookup
    Geocoder.search(@zipcode)
    data = results[0].data
    @lat = data["geometry"]["location"]["lat"]
    @lng = data["geometry"]["location"]["lng"]
  end

  def return_results_hash
    {lat: @lat, lng: @lng}
  end

end