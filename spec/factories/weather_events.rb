# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weather_event do
    site_id 1
    eventdate "2012-02-20 14:01:37"
    duration 1.5
    rainfall 1.5
    inspected false
    qualifying false
  end
end
