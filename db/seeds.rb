require 'pp'

DATAFILE = File.join(Rails.root, 'db', 'seed_data', 'zipcodes.txt')

# Clear all location data
Location.delete_all

# Read the contents of the dump file from geonames
Location.transaction do 
  File.open(DATAFILE, 'r').each_with_index do |line,idx|
    zip,name,lat,long = line.split("\t").values_at(1,5,9,10)
    Location.create({
      zipcode: zip,
      lat: lat,
      long: long,
      name: name
    })
    pp "#{idx} lines imported" if idx % 100 == 0

    break if idx > 500
  end
end

pp 'user seed data'
User.destroy_all

user = User.create!(
  email: 'vader@starwars.com',
  password: 'stormpopwho?',
  password_confirmation: 'stormpopwho?'
)

# pp "project seed data"
# Project.destroy_all
# hwy_101 = Project.create!(
#   name: 'Hwy 101 Corridor',
#   description: 'Highway Improvements',
#   startdate: '2011-02-20 12:01:00',
#   finishdate: '2012-02-20 12:01:00'
# )
# dt_oakland = Project.create!(
#   name: 'DT Oakland',
#   description: 'Downtown Oakland Junction',
#   startdate: '2012-03-01 12:01:00',
#   finishdate: '2012-03-12 12:01:00'
# )

pp 'site seed data'
Site.destroy_all

user.sites.create!({
  name: 'Sausalito 101',
  address_1: 'HWY 101',
  city: 'Sausalito',
  zipcode: 94965,
  user: user
}, without_protection: true)
user.sites.create!({
  name: 'Sears Oakland',
  address_1: '1955 Broadway',
  city: 'Oakland',
  zipcode: 94612,
  user: user
}, without_protection: true)
user.sites.create!({
  name: 'Portland',
  address_1: '100 Main Street',
  city: 'Portland',
  zipcode: 97001,
  user: user
}, without_protection: true)
user.sites.create!({
  name: 'San Francisco',
  address_1: '100 Main Street',
  city: 'San Francisco',
  zipcode: 94120,
  user: user
}, without_protection: true)
user.sites.create!({
  name: 'Seattle',
  address_1: '100 Main Street',
  city: 'Seattle',
  zipcode: 98101,
  user: user
}, without_protection: true)
user.sites.create!({
  name: 'Los Angeles',
  address_1: '100 Main Street',
  city: 'Los Angeles',
  zipcode: 99994,
  user: user
}, without_protection: true)
# hwy_101.sites << Site.all.to_a
