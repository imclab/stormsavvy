class Site < ActiveRecord::Base
  belongs_to :project

  attr_accessible :name, :description, :costcode, :size
end



