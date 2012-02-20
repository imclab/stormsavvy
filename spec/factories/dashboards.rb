# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dashboard do
    user_id 1
    preferences "MyText"
  end
end
