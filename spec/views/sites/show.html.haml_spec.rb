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
    rendered.should match(/NOAA Forecast Table/)
    rendered.should match(/7-Day Forecast/)
    rendered.should match(/Date/)
    rendered.should match(/Chance of Rain/)
    rendered.should match(/Forecast Rain/)
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
