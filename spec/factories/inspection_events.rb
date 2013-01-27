# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inspection_event do
    site_id 1
    inspection_type "MyString"
    inspection_description "MyText"
    inspection_date "2013-01-26 23:13:55"
    submitted_by "MyString"
    inspected_by "MyString"
  end
end
