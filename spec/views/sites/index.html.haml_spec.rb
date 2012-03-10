require 'spec_helper'

describe "sites/index" do
  before(:each) do
    assign(:sites, [
      stub_model(Site,
        :name => "Name",
        :description => "Description",
        :costcode => "Costcode",
        :size => "Size",
        :exposed_area => "Exposed Area",
        :location => "Location"
      ),
      stub_model(Site,
        :name => "Name",
        :description => "Description",
        :costcode => "Costcode",
        :size => "Size",
        :exposed_area => "Exposed Area",
        :location => "Location"
      )
    ])
  end

  xit "renders a list of sites" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Costcode".to_s, :count => 2
    assert_select "tr>td", :text => "Size".to_s, :count => 2
    assert_select "tr>td", :text => "Exposed Area".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
