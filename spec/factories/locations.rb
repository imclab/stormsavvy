# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    zipcode "94503"
    lat      37.9202057
    long    -122.293742
    name    'El Cerrito'
  end
end
