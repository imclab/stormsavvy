require 'spec_helper'

describe "sites/new" do

  before(:each) do
    assign(:site, stub_model(Site,
      :name => "MyString",
      :description => "MyString",
      :costcode => "MyString",
      :size => "MyString",
      :exposed_area => "MyString",
      :location => "MyString"
    ).as_new_record)
    render
  end

  it "renders new site form" do
    assert_select "form", :action => sites_path, :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_description", :name => "site[description]"
      assert_select "input#site_costcode", :name => "site[costcode]"
      # assert_select "input#site_size", :name => "site[size]"
      # assert_select "input#site_exposed_area", :name => "site[exposed_area]"
      # assert_select "input#site_location", :name => "site[location]"
    end
  end

  it "renders site attributes" do
    rendered.should match(/Project EA/)
    rendered.should match(/Project Costcode/)
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/Address 1/)
    rendered.should match(/Address 2/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zipcode/)
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
    rendered.should match(/Last BMP Status Report Date/)
    rendered.should match(/Last Weekly Inspection Date /)
    rendered.should match(/Last Corrective Action Report Date/)
    rendered.should match(/Last REAP Report Date/)
    rendered.should match(/Last Training Report Date/)
    rendered.should match(/Last Weather Forecast Date/)
    rendered.should match(/Last Rain Event Sampling Date/)
  end
end
