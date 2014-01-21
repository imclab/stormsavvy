require 'weather/noaa_forecast'
require 'weather/forecast_examiner'

class Site < ActiveRecord::Base

  attr_accessible :name,
    :description,
    :costcode,
    :size,
    :address_1,
    :address_2,
    :state,
    :zipcode,
    :city,
    :exposed_area,
    :project_attributes,
    :lat,
    :long

  belongs_to :user #, counter_cache: true

  has_many :reports, :dependent => :destroy
  has_many :inspection_events, :dependent => :destroy
  has_many :inspection_event_workflows, :dependent => :destroy
  has_many :sampling_events, :dependent => :destroy
  has_many :weather_updates
  has_many :forecast_periods

  # accepts_nested_attributes_for :user
  # accepts_nested_attributes_for :inspection_event

  after_validation :save_geo_coordinates, if: :zipcode_changed?

  validates :zipcode, :name, :zipcode, :presence => true

  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}".strip
  end

  attr_reader :rain_state, :max_rain, :chance_of_rain, :forecast, :forecast_table

  def chance_of_rain
    nfs = NoaaForecastService.new(site: self)
    nfs.site_forecast(self)
    forecast_period = self.forecast_periods.where('forecast_prediction_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
    forecast_period.order('pop DESC').first
  end

  def forecast_table
    nfs = NoaaForecastService.new(site: self)
    nfs.forecast_table(self)
  end

  def forecast
    #zipcode = 90210 unless self.zipcode.present?
    #nf.forecast(@lat, @long)

    nf = NOAAForecast.new(zipcode.to_i)
    forecast = nf.seven_day_weather(zipcode.to_i)
    precipitation_state(forecast)
    @forecast = forecast

    #precipitation_state(nf.noaa_forecast)
    #@forecast = nf.noaa_forecast

    # zipcode = 90210 unless self.zipcode.present?
    # nf = NOAAForecast.new(zipcode.to_i)
    # forecast = nf.seven_day_weather(zipcode.to_i)
    # nf.forecast(@lat, @long)
    # precipitation_state(forecast)
    # @forecast = nf.seven_day_weather(zipcode.to_i)
    # precipitation_state(nf.noaa_forecast)
    # @forecast = nf.noaa_forecast
  end

  def precipitation_state(forecast)
    if forecast == [[],[]]
      @rain_state = :null
      return
    end
    fe = ForecastExaminer.new(self, forecast)
    fe.find_rain_chance()
    @rain_state = fe.rain
  end

  def save_geo_coordinates
    unless lat.presence && long.presence
      begin
        service = GeocoderService.new(zipcode: zipcode)
        self.update_attributes(service.get_lat_lng)
      rescue => e
      end
    end
  end

  def latlng
    [self.lat, self.long]
  end

  def get_zipcode
    return self.zipcode.to_s
  end
end
