require 'weather/noaa_forecast'
require 'weather/forecast_examiner'

class Site < ActiveRecord::Base

  attr_accessible :name, :description, :costcode, :size, :address_1, :address_2, :state, :zipcode, :city, :exposed_area

  belongs_to :project
  has_many :reports
  has_many :site_pop

  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_validation :geocode

  validates_presence_of :name
  validates :zipcode, :presence => true


  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}".strip
  end


  attr_reader :rain_state, :max_rain
  
  def chance_of_rain
    #zipcode = 90210 unless self.zipcode.present?
    nf = NOAAForecast.new(@zipcode)
    #nf.seven_day_weather(@zipcode)
    #binding.pry
    nf.forecast(@lat, @long)
    precipitation_state(nf.noaa_forecast)
    @max_rain = nf.noaa_forecast[0][0..4].max
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

end
