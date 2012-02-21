# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inspection_event do
    site_id 1
    type ""
    description "MyText"
    date "2012-02-20 14:47:45"
    submitted "2012-02-20 14:47:45"
  end
end
