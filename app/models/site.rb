class Site < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :name

  attr_accessible :name, :description, :costcode, :size
end



