# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rain_event_workflow do
    hours_before_rain 1
    reap false
    cem2030 false
    ph_sample false
    turbidity false
    report_sent false
    report_received false
  end
end
