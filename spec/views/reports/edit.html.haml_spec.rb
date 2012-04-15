require 'spec_helper'

describe "reports/edit" do

  # before(:each) do
  #   @report = Factory(:report)
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

      assert_select "input#contractor_name", 
           :name => "report[contractor_name]"
      assert_select "input#contractor_address_1", 
           :name => "report[contractor_address_1]"
      assert_select "input#contractor_address_2", 
           :name => "report[contractor_address_2]"
      assert_select "input#contractor_city", 
           :name => "report[contractor_city]"
      assert_select "input#contractor_state", 
           :name => "report[contractor_state]"
      assert_select "input#contractor_zipcode", 
           :name => "report[contractor_zipcode]"        

      assert_select "input#contract_number", 
           :name => "report[contract_number]"
      assert_select "input#project_identifier_number", 
           :name => "report[project_identifier_number]"
      assert_select "input#wdid_number", 
           :name => "report[wdid_number]"
      assert_select "input#status", 
           :name => "report[status]"

      assert_select "input#submitted_by_contractor", 
           :name => "report[submitted_by_contractor]"
      assert_select "input#submitted_by_date", 
           :name => "report[submitted_by_date]"

      assert_select "input#wpc_manager", 
           :name => "report[wpc_manager]"
      assert_select "input#wpc_phone", 
           :name => "report[wpc_phone]"
      assert_select "input#wpc_emergency_phone", 
           :name => "report[wpc_emergency_phone]"

      assert_select "input#inspector_name", 
           :name => "report[inspector_name]"
      assert_select "input#inspection_date", 
           :name => "report[inspection_date]"

      assert_select "input#weather_condition", 
           :name => "report[weather_condition]"      
      assert_select "input#precipitation_condition", 
           :name => "report[precipitation_condition]"
      assert_select "input#wind_condition", 
           :name => "report[wind_condition]"

      assert_select "input#construction_phase", 
           :name => "report[construction_phase]"

      assert_select "input#total_area", 
           :name => "report[total_area]"
      assert_select "input#total_DSA", 
           :name => "report[total_DSA]"
      assert_select "input#current_DSA", 
           :name => "report[current_DSA]"
      assert_select "input#inactive_DSA", 
           :name => "report[inactive_DSA]"

      assert_select "input#inspection_type", 
           :name => "report[inspection_type]"

      assert_select "input#time_elapsed_last_storm", 
           :name => "report[time_elapsed_last_storm]"
      assert_select "input#precpitation_received", 
           :name => "report[precpitation_received]"          
      assert_select "input#time_storm_expected", 
           :name => "report[time_storm_expected]"
      assert_select "input#expected_precipitation_amount", 
           :name => "report[expected_precipitation_amount]"
      assert_select "input#time_elapsed_during_storm", 
           :name => "report[time_elapsed_during_storm]"           
      assert_select "input#gauge_reading_during_storm", 
           :name => "report[gauge_reading_during_storm]"
      assert_select "input#time_elapsed_post_storm", 
           :name => "report[time_elapsed_post_storm]"           
      assert_select "input#gauge_reading_post_storm", 
           :name => "report[gauge_reading_post_storm]"      
    end
  end
end
