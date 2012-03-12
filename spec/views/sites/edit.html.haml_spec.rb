require 'spec_helper'

describe "sites/edit" do
  before(:each) do
    @site = assign(:site, stub_model(Site,
      :name => "MyString",
      :description => "MyString",
      :costcode => "MyString",
      :size => "MyString",
      :exposed_area => "MyString"
    ))
  end

  xit "renders the edit site form" do
    render
    assert_select "form", :action => site_path(@site.project_id, @site), :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_description", :name => "site[description]"
      assert_select "input#site_costcode", :name => "site[costcode]"
      assert_select "input#site_size", :name => "site[size]"
      assert_select "input#site_exposed_area", :name => "site[exposed_area]"
    end
  end
end
