require 'spec_helper'

describe FirstReport do

  before(:each) do
    @report = FactoryGirl.create(:report)
    @site = @project.sites.create!({:name => 'EC Jungle Gym', 
      :zipcode => '94530'})
  end

  describe :build_report do
    
  end
end