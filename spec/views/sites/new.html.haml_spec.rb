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
  end

  it "renders new site form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sites_path, :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_description", :name => "site[description]"
      assert_select "input#site_costcode", :name => "site[costcode]"
      assert_select "input#site_size", :name => "site[size]"
      assert_select "input#site_exposed_area", :name => "site[exposed_area]"
      #assert_select "input#site_location", :name => "site[location]"
    end
  end
end
