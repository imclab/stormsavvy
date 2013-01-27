require 'spec_helper'

describe InspectionEvent do

  before :each do
  	@inspection_event = FactoryGirl.create(:inspection_event)
  	@attr = {
	  :site_id => 1,
	  :inspection_type => "weekly",
	  :inspection_description => "ec jungle gym inspection",
	  :inspection_date => "2013-01-26 23:13:55",
	  :submitted_by => "wyu",
	  :inspected_by => "wyu"
=begin  		
  	  :name => "Hwy 99",
  	  :description => "Pothole Repair",
  	  :startdate => DateTime.new(2010),
  	  :finishdate => DateTime.new(2011),
  	  :active => true
=end
  	}
  end

end
