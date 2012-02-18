
# By using the symbol ':member', we get Factory Girl to simulate the Member model.
# This is from the Rails Tutorial Listing 7.16
Factory.define :user do |u|
  u.email                 "david.doolin+3@example.com"
  u.password              "foobar"
  u.firstname             "Dave"
  u.lastname              "Doolin"
end


Factory.define :site do |s|
  s.name           "Marin Shores"
  s.description    "Some short, descriptive text for testing."
end


Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
