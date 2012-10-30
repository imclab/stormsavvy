FactoryGirl.define do
  factory :rain_event_workflow do
    hours_before_rain 1
    chance_of_rain 35
    amount_of_rain 0.45
    reap false
    cem2030 false
    ph_sample false
    turbidity false
    report_sent false
    report_received false
  end
end
