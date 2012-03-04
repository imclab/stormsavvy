require 'spec_helper'

describe Project do

  before(:each) do
    @project = Project.create(
	  :name => "Hwy 1",
	  :description => "AC Overlay", 
	  :startdate => "2011-02-20 12:01:00",
	  :startdate => "2012-02-20 12:01:00" 
	  )
 end

  pending "add some examples to (or delete) #{__FILE__}"
end
