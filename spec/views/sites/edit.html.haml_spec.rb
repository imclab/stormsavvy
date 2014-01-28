require 'spec_helper'

describe "sites/edit" do

  let(:user) { FactoryGirl.build(:user) }
  # @user = FactoryGirl.create(:user)
  let(:site) { FactoryGirl.create(:site, user: user) }
  # @site = @user.sites.create!({:name => 'ecp', :zipcode => '94530'})

  before(:each) do
    @user = FactoryGirl.build(:user)
    @site = FactoryGirl.create(:site, user: user)
    render
  end

  it "renders the edit site form" do
    assert_select "form", :method => 'post' do #:action => site_path(@site.project_id, @site), :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_description", :name => "site[description]"
      assert_select "input#site_costcode", :name => "site[costcode]"
    end
  end

  it "renders site attributes" do
    rendered.should match(/Project EA/)
    rendered.should match(/Project Costcode/)
    rendered.should match(/Site Name/)
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
