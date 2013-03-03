class InspectionEventWorkflow < ActiveRecord::Base
  attr_accessible :amount_of_rain, :cem2023, :cem2024, :cem2034, :cem2035, :cem2040, :chance_of_rain, :during_storm_inspection, :forecast_rain, :hours_before_rain, :inspection_event, :notice_of_discharge, :ph_sample, :post_storm_inspection, :pre_storm_inspection, :quarterly_inspction, :reap, :report_received, :report_sent, :turbidity
end
