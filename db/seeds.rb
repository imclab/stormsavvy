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

pp "User seed data"
User.destroy_all
user = User.create!(
  :firstname => "Jim",
  :lastname => "Nelson",
  :email => "jim.nelson@test.com",
  :password => "tester"
  )

pp "Project seed data"
Project.destroy_all
hwy_101 = Project.create!(
  :name => "Hwy 101 Corridor",
  :description => "Highway irmprovements in Marin/Sonoma counties", 
  :startdate => "2011-02-20 12:01:00",
  :finishdate => "2012-02-20 12:01:00"
  )

dt_oakland = Project.create!(
  :name => "DT Oakland",
  :description => "Downtown Oakland Junction",
  :startdate => "2012-03-01 12:01:00",
  :finishdate => "2012-03-12 12:01:00"
  )

# user.projects << hwy_101
# user.projects << dt_oakland

pp "Sites seed data"
Site.destroy_all

Site.create!(
  :name => "Sausalito 101",
  :address_1 => "HWY 101",
  :city => "Sausalito",
  :zipcode => "99999"
  )

Site.create!(
  :name => "Sears Oakland",
  :address_1 => "1955 Broadway",
  :city => "Oakland",
  :zipcode => "99998"
  )

Site.create!(
  :name => "Portland",
  :address_1 => "100 Main Street",
  :city => "Portland",
  :zipcode => "99997"
  )

Site.create!(
  :name => "San Francisco",
  :address_1 => "100 Main Street",
  :city => "San Francisco",
  :zipcode => "99996"
  )

Site.create!(
  :name => "Seattle",
  :address_1 => "100 Main Street",
  :city => "Seattle",
  :zipcode => "99995"
  )

Site.create!(
  :name => "Los Angeles",
  :address_1 => "100 Main Street",
  :city => "Los Angeles",
  :zipcode => "99994"
  )

hwy_101.sites << Site.all.to_a

# Site seed data
Site.create!(
  :name => "MSN-A1",
  :description => "Hwy 101 Novato - PM 18.6-22.3",
  :costcode => "264064",
  :size => "20 acres",
  #:address1 => "320 Deere Lane",
  #:address2 => "",
  :state => "California",
  :zipcode => "99999",
  :city => "Novato",
  :exposed_area => "10 acres"
  )

# User seed data
User.create!(
  :email => "name@stormsavvy.com",
  :password => "Dark&Stormy",
  :password_confirmation => "Dark&Stormy"
  )
