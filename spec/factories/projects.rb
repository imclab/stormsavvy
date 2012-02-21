# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    user_id 1
    name "MyString"
    description "MyText"
    startdate "2012-02-20 13:15:11"
    finishdate "2012-02-20 13:15:11"
    active false
  end
end
