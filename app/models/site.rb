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

  belongs_to :project
  has_many :reports
  has_many :site_pop
  accepts_nested_attributes_for :project

  geocoded_by :address, 
    :latitude => :lat, 
    :longitude => :long
  after_validation :geocode

  validates_presence_of :name,
    :zipcode
  validates :zipcode, :presence => true

  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}".strip
  end

  attr_reader :rain_state, :max_rain, :chance_of_rain, :forecast

  def chance_of_rain
    #zipcode = 90210 unless self.zipcode.present?
    nf = NOAAForecast.new(zipcode.to_i)
    nf.seven_day_weather
    #nf.forecast(@lat, @long)
    precipitation_state(nf.seven_day_weather)
    @max_rain = nf.seven_day_weather[0][0..5].max
  end

  def forecast
    #zipcode = 90210 unless self.zipcode.present?
    nf = NOAAForecast.new(zipcode.to_i)
    nf.seven_day_weather
    #nf.forecast(@lat, @long)
    
    precipitation_state(nf.seven_day_weather)
    @forecast = nf.seven_day_weather

    #precipitation_state(nf.noaa_forecast)
    #@forecast = nf.noaa_forecast
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

  def get_zipcode
    return self.zipcode.to_s
  end
end
