require 'spec_helper'

describe "sites/edit" do

  before(:each) do
    @user = Factory(:user)
    @project = @user.projects.create!({:name => 'foo', :description => 'bar', :startdate => 5.days.ago, :finishdate => 1.day.ago})
    @site = @project.sites.create!({:name => 'foo site', :zipcode => '94530'})
  end

  it "renders the edit site form" do
    render
    assert_select "form", :method => 'post' do #:action => site_path(@site.project_id, @site), :method => "post" do
      assert_select "input#site_name", :name => "site[name]"
      assert_select "input#site_description", :name => "site[description]"
      assert_select "input#site_costcode", :name => "site[costcode]"
      assert_select "input#site_size", :name => "site[size]"
      assert_select "input#site_exposed_area", :name => "site[exposed_area]"
    end
  end
end
