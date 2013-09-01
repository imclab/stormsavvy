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
    :project_attributes

  belongs_to :project, counter_cache: true
  has_many :reports, :dependent => :destroy
  has_many :inspection_events, :dependent => :destroy
  has_many :inspection_event_workflows, :dependent => :destroy
  has_many :sampling_events, :dependent => :destroy
  has_many :site_pop, :dependent => :destroy
  accepts_nested_attributes_for :project

  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_validation :geocode

  validates_presence_of :name, :zipcode
  validates :zipcode, :presence => true

  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}".strip
  end

  attr_reader :rain_state, :max_rain, :chance_of_rain, :forecast

  def chance_of_rain
    process_noaa_forecast
    precipitation_state(forecast)
    @max_rain = forecast[0][0..5].max
    @max_rain.to_i
  end

  def forecast
    process_noaa_forecast
    precipitation_state(forecast)
    @forecast = forecast
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


    self.update_attributes(lat: lat, lng: lng)
  end

  def latlng
    [self.lat, self.lng]
  end

  def get_zipcode
    return self.zipcode.to_s
  end

  private

  def process_noaa_forecast
    nf = NOAAForecast.new(zipcode.to_i)
    forecast = nf.seven_day_weather
  end
end
