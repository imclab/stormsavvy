require 'spec_helper'

describe "reports/edit" do

  # before(:each) do
  #   @report = FactoryGirl.create(:report)
  # end

  xit "renders the edit report form" do
    render
    xassert_select "form", :method => 'post' do 
      assert_select "input#site_information_name", 
           :name => "report[site_information_name]"
      assert_select "input#site_address_1", 
           :name => "report[site_address_1]"
      assert_select "input#site_address_2", 
           :name => "report[site_address_2]"
      assert_select "input#site_city", 
           :name => "report[site_city]"
      assert_select "input#site_state", 
           :name => "report[site_state]"
      assert_select "input#site_zipcode", 
           :name => "report[site_zipcode]"
    end
  end
end
