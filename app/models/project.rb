class Project < ActiveRecord::Base
  belongs_to :user
  has_many :sites

  attr_accessible :name, :description, :startdate, :finishdate, :active
end
