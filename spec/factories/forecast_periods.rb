# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forecast_period do
    forecast_prediction_time "2013-09-02 19:25:22"
    temperature 1
    dewpoint 1
    rh 1
    sky_cover 1
    wind_speed 1
    wind_direction 1
    wind_gust 1
    pop 1
    qpf 1.5
    snow_amount 1.5
    snow_level 1
    wx "MyString"
    site nil
    weather_update nil
  end
end
