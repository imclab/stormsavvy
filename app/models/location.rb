class Location < ActiveRecord::Base
  validates_presence_of :zipcode
  validates_presence_of :lat
  validates_presence_of :long
end
