require 'spec_helper'

describe "sites/show" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :description => "Description",
      :costcode => "Costcode",
      :size => "Size",
      :exposed_area => "Exposed Area"
    ))
    @project = FactoryGirl.create(:project)
    @site.project_id = @project.id

    render
  end

  it "renders site attributes" do
    rendered.should match(/Project/)
    rendered.should match(/Project EA/)
    rendered.should match(/Project Costcode/)
    rendered.should match(/Site ID/)
    rendered.should match(/Site Name/)
    rendered.should match(/Description/)
    rendered.should match(/Address 1/)
    rendered.should match(/Address 2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zipcode/)
    rendered.should match(/Lat/)
    rendered.should match(/Long/)
    rendered.should match(/Risk Level/)
    rendered.should match(/WDID Number/)
    rendered.should match(/Construction Phase/)
    rendered.should match(/Total Area/)
    rendered.should match(/Total DSA/)
    rendered.should match(/Current DSA/)
    rendered.should match(/Inactive DSA/)
    rendered.should match(/Time Since Last Storm/)
    rendered.should match(/Precipitation Received During Last Storm/)
    rendered.should match(/Inactive DSA/)
    rendered.should match(/Contractor Name/)
    rendered.should match(/Contractor Address 1/)
    rendered.should match(/Contractor Address 2/)
    rendered.should match(/Contractor City/)
    rendered.should match(/Contractor State/)
    rendered.should match(/Contractor Zipcode/)
    rendered.should match(/WPCM Name/)
    rendered.should match(/WPCM Company/)
    rendered.should match(/WPCM Phone Number/)
    rendered.should match(/WPCM Emergency Phone Number/)
    rendered.should match(/QSP Name/)
    rendered.should match(/QSP Company/)
    rendered.should match(/QSP Phone Number/)
    rendered.should match(/QSP Emergency Phone Number/)
    rendered.should match(/Permits/)
    rendered.should match(/Resident Engineer Name/)
    rendered.should match(/Structures Representative Name/)
    rendered.should match(/Last BMP Status Report Date (CEM 2034)/)
    rendered.should match(/Last Weekly Inspection Date (CEM 2030)/)
    rendered.should match(/Last Corrective Action Report Date (CEM 2035)/)
    rendered.should match(/Last REAP Report Date (CEM 2045)/)
    rendered.should match(/Last Training Report Date (CEM 2023)/)
    rendered.should match(/Last Weather Forecast Date (CEM 2040)/)
    rendered.should match(/Last Rain Event Sampling Date (CEM 2051)/)

    rendered.should match(/NOAA Forecast Table/)
    rendered.should match(/7-Day Forecast/)
    rendered.should match(/Date/)
    rendered.should match(/Chance of Rain/)
    rendered.should match(/Forecast Rain/)

    rendered.should match(/Size/)
    rendered.should match(/Exposed Area/)
  end

  it "has edit, back and delete links" do
    rendered.should match(/Edit/)
    rendered.should match(/Back/)
    rendered.should match(/Delete/)

    rendered.should have_link('Edit')
    rendered.should have_link('Back')
    rendered.should have_button('Delete This Site')
  end
end
