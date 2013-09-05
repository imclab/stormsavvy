# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weather_update do
    site nil
    forecast_creation_time "2013-09-02 16:45:33"
    lat 1.5
    lng 1.5
    elevation 1
    duration 1
    interval 1
  end
end
