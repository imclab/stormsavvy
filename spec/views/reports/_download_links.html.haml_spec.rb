require 'spec_helper'

describe "reports/_download_links" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end
  
  it "renders download_links partial correctly" do    
    render
    rendered.should_not be_nil
    rendered.should =~ /Download File/
    rendered.should =~ /Edit/
    rendered.should =~ /Delete/
    rendered.should =~ /Back/
    # rendered.should =~ /Weekly Inspection (CEM2030)/
    # rendered.should =~ /Page 1/
    # rendered.should =~ /Site Information/
    # rendered.should =~ /Company Information/
    # rendered.should =~ /Contract Information/
    # rendered.should =~ /Submittal Information/
    # rendered.should =~ /WPC Information/
    # rendered.should =~ /Inspector Name/
    # rendered.should =~ /Weather Conditions/
    # rendered.should =~ /Wind Conditions/
    # rendered.should =~ /Precipitation Conditions/
    # rendered.should =~ /Construction Phase/
    # rendered.should =~ /Inspection Type/
    # rendered.should =~ /Site Area/
  end
end
