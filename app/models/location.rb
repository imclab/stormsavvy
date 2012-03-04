class Location < ActiveRecord::Base
  validates_presence_of :zipcode
  validates_presence_of :lat
  validates_presence_of :long

  def self.latlong(zipcode)
    l = Location.where(:zipcode => zipcode).first
    [] << l.lat << l.long
  end
end
