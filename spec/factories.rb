# By using the symbol ':member', we get Factory Girl to simulate the Member model.
# This is from the Rails Tutorial Listing 7.16
FactoryGirl.define do
  factory :user do |u|
    u.email                 "david.doolin+3@example.com"
    u.password              "foobar"
    u.firstname             "Dave"
    u.lastname              "Doolin"
  end
end

#FactoryGirl.sequence :email do |n|
#  "person-#{n}@example.com"
#end
