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

  # CEM 2030 fields - page 1:
  :type,
  :site_information_name,
  :site_address_1,
  :site_address_2,
  :site_city,
  :site_state,
  :site_zipcode,

  :contractor_name,
  :contractor_address_1,
  :contractor_address_2,
  :contractor_city,
  :contactor_state,
  :contactor_zipcode,

  :contract_number,
  :project_identifer_number,
  :wdid_number,
  :status,

  :submitted_by_contractor,
  :submitted_by_date,

  :wpc_manager,
  :wpc_phone,
  :wpc_emergency_phone,

  :inspector_name,
  :inspection_date,

  :weather_condition, 
  # clear / partly cloudy / cloudy

  :precipitation_condition, 
  # misty/ light_rain / rain / heavy_rain / hail / snow

  :wind_condition,
  # none / less_5mph / more_5mph

  :construction_phase,
  # highway_construction / plant_establishment / 
  # suspension_of_work

  :total_area, 
  :total_DSA, 
  :current_DSA, 
  :inactive_DSA,

  :inspection_type,
  # weekly / quarterly / pre_storm / during_storm / 
  # post-storm

  :time_elapsed_last_storm, 
  # x_days

  :precipitation_received, 
  # x_inches

  :time_storm_expected, 
  # x_time, x_date

  :expected_precipitation_amount,
  # x_inches

  :time_elapsed_during_storm, 
  # x_hours_minutes

  :gauge_reading_during_storm, 
  # x_inches

  :time_elapsed_post_storm, 
  # x_hours_minutes

  :gauge_reading_post_storm
  # x_inches

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


  attr_reader :rain_state, :max_rain, :chance_of_rain
  
  def chance_of_rain
    #zipcode = 90210 unless self.zipcode.present?
    #binding.pry
    nf = NOAAForecast.new(zipcode.to_i)
    nf.seven_day_weather
    #nf.forecast(@lat, @long)
    precipitation_state(nf.noaa_forecast)
    @max_rain = nf.noaa_forecast[0][0..5].max
    #binding.pry
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
