class Location < ActiveRecord::Base

  geocoded_by :address, :latitude => :lat, :longitude => :long
  after_save :geocode

=begin
  # TODO: hook this up to deal with cached locations.
  def latlong(zipcode)
    l = Location.where(:zipcode => zipcode).first
    [] << l.lat << l.long
  end
=end

  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}"
  end
end
