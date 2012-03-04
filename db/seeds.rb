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
@project = Project.create(
  :name => "Hwy 1",
  :description => "AC Overlay", 
  :startdate => "2011-02-20 12:01:00",
  :startdate => "2012-02-20 12:01:00" 
  )

# Site seed data

