# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    user_id      1
    name        "Hwy 101 Corridor"
    description "Highway Improvements"
    startdate    DateTime.new
    finishdate   DateTime.new
    active       false
  end
end
