FactoryGirl.define do
  factory :sampling_event_workflow do
    site_id 1
    hours_before_rain 1
    chance_of_rain 35
    amount_of_rain 0.45
    cem2051 false
    cem2052 false
    ph_sample false
    turbidity false
    report_sent false
    report_received false
    forecast_rain 0.45
    sampling_event false
  end
end
