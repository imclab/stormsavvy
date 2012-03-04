class Site < ActiveRecord::Base

  attr_accessible :name, :description, :costcode, :size, :address_1, :address_2, :state, :zipcode, :city, :exposed_area

  belongs_to :project
  geocoded_by :address, :latitude => :lat, :longitude => :long


  after_validation :geocode

  def self.latlong(zipcode)
    l = self.where(:zipcode => zipcode).first
    [] << l.lat << l.long
  end

  def address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state} #{self.zipcode}"
  end

end
