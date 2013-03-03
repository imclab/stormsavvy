# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inspection_event_workflow do
    hours_before_rain 1
    reap false
    cem2023 false
    cem2024 false
    cem2034 false
    cem2035 false
    cem2040 false
    pre_storm_inspection false
    during_storm_inspection false
    post_storm_inspection false
    report_sent false
    report_received false
    ph_sample false
    turbidity false
    notice_of_discharge false
    quarterly_inspction false
    chance_of_rain 1
    amount_of_rain 1.5
    forecast_rain 1.5
    inspection_event false
  end
end
