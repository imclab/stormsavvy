# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    zipcode 1
    lat 1.5
    long 1.5
  end
end
