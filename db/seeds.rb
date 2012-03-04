DATAFILE = File.join(Rails.root, 'db', 'seed_data', 'zipcodes.txt')

# Clear all location data
Location.delete_all

# Read the contents of the dump file from geonames
Location.transaction do 
  File.open(DATAFILE, 'r').each_with_index do |line,idx|
    zip,name,lat,long = line.split("\t").values_at(1,5,9,10)
    l = Location.create({ 
      :zipcode => zip, 
      :lat => lat, 
      :long => long, 
      :name => name 
    })
    puts "#{idx} lines imported" if idx % 100 == 0
  end
end

# Project seed data
Project.create(
  :name => "Hwy 101 Corridor",
  :description => "Highway irmprovements in Marin/Sonoma counties", 
  :startdate => "2011-02-20 12:01:00",
  :startdate => "2012-02-20 12:01:00" 
  )

# Site seed data
Site.create(
  :name => "MSN-A1",
  :description => "Hwy 101 Novato - PM 18.6-22.3",
  :costcode => "264064", 
  :size => "20 acres", 
  :address1 => "320 Deere Lane",
  :address2 => "", 
  :state=> "California", 
  :zipcode => "99999", 
  :city => "Novato", 
  :exposed_area => "10 acres"
  )

# User seed data
User.create(
  :email => "name@stormsavvy.com", 
  :password => "Dark&Stormy",
  :password_confirmation => "Dark&Stormy")

# 