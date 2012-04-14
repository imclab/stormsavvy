class Report < ActiveRecord::Base

  scope :needs_attention, where(status: "needs_attention")
  scope :completed, where(status: "complete")

  belongs_to :site

  attr_accessible :type,
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

  :wpc_manager
  :wpc_phone
  :wpc_emergency_phone

  :inspector_name
  :inspection_date

  :weather_condition # clear / partly cloudy / cloudy

  :precipitation_condition >> misty/ light_rain / rain /
heavy_rain / hail / snow

:wind_condition >> none / less_5mph / more_5mph

:construction_phase >> highway_construction /
plant_establishment / suspension_of_work

:site_information >> total_area / total_DSA /
current_DSA / inactive_DSA

:inspection type >> weekly / quarterly / pre_storm /
during_storm / post-storm

:time_elapsed >> x_days
:precipitation_received >> x_inches
:time_storm_expected >> x_time, x_date
:expected_precipitation_amount >> x_inches
:time_elapsed >> x_hours_minutes
:gauge_reading >> x_inches
:time_elapsed_began >> x_hours_minutes
:gauge_reading_began >> x_inches



  before_update :change_report_status

private

  def change_report_status
    self.status = "complete"
  end

end
