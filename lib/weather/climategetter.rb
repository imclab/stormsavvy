require 'typhoeus'
require 'json'

include Typhoeus

NCDC_CDO_KEY = ENV["NCDC_CDO_KEY"]

class ClimateGetter

  attr_reader :climate

  def initialize
  end

  def make_request(url)
    # begin
      request = Typhoeus::Request.new(
        url,
        method: :get,
        timeout: 8000, # milliseconds
        headers: { token: NCDC_CDO_KEY }
        # cache_timeout: 60 # seconds
      )
      @hydra.queue(request)
      @hydra.run
      response = request.response
      data = JSON.parse(response.body)
      return data
    # rescue => e
    #  pp e
    # end
  end

  def make_request_with_cache(url, expire_time)
    cache_backup = Rails.cache.read('url')
    api_data = Rails.cache.fetch('url', expires_in: expire_time) do

      new_data = make_request(url)

      if new_data.blank?
        cache_backup
      else
        new_data
      end
    end
    return api_data
  end

  def log_response(request)
    request.on_complete do |response|
      if response.success?
        @hydra.queue(request)
        @hydra.run
        response = request.response
        data = JSON.parse(response.body)
        return data
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

  def get_station(site)
    @hydra = Typhoeus::Hydra.new
    lat_up = site.lat + 0.5
    long_up = site.long + 0.5
    lat_down = site.lat - 0.5
    long_down = site.long - 0.5
    base_url = "http://www.ncdc.noaa.gov/cdo-web/api/v2/stations?"
    url = "#{base_url}extent=#{lat_up},#{long_up},#{lat_down},#{long_down}"
    @station = make_request(url)
  end
end
