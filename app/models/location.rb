class Location < ActiveRecord::Base

  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_save :geocode

  def latlong(zipcode)
    l = Location.where(:zipcode => zipcode).first
    [] << l.lat << l.long
  end

  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}"
  end
end
