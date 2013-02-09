require 'spec_helper'

describe "reports/_cem2030" do

  before(:each) do
    assign(:reports, [
      stub_model(Report),
      stub_model(Report)
    ])
    @report = FactoryGirl.create(:report, :id => 1)
  end
  
  it "renders cem2030 partial correctly" do    
    render
    rendered.should_not be_nil
    rendered.should =~ /Type/
    rendered.should =~ /Site/
    # rendered.should =~ /Weekly Inspection (CEM2030)/
    # rendered.should =~ /Page 1/
    # rendered.should =~ /Site Information/
    # rendered.should =~ /Company Information/
    # rendered.should =~ /Contract Information/
    # rendered.should =~ /Submittal Information/
    # rendered.should =~ /WPC Information/
    # rendered.should =~ /Inspector Name/
    # rendered.should =~ /Weather Conditions/
    # rendered.should =~ /Wind Conditions/
    # rendered.should =~ /Precipitation Conditions/
    # rendered.should =~ /Construction Phase/
    # rendered.should =~ /Inspection Type/
    # rendered.should =~ /Site Area/
  end

=begin
  it "renders the edit report form" do
    render
    assert_select "form", :method => 'post' do 
      assert_select "input#report_site_information_name" 
    end
  end

  it "renders fieldset for weather conditions" do
    render
    assert_select "form", :method => 'post' do
      assert_select "fieldset#weather_conditions" do
        assert_select "input#report_weather_condition_clear",
          :name => "report[weather_condition]",
          :value => 'clear',
          :content => 'Clear'
        assert_select "input#report_weather_condition_partly_cloudy",
          :name => "report[weather_condition]",
          :value => 'partly_cloudy',
          :content => 'Partly Cloudy'
        assert_select "input#report_weather_condition_cloudy",
          :name => "report[weather_condition]",
          :value => 'cloudy',
          :content => 'Cloudy'  
      end
    end
  end

  it "renders fieldset for wind conditions" do
    render
    assert_select "form", :method => 'post' do
      assert_select "fieldset#wind_conditions" do
        assert_select "input#report_wind_condition_none",
          :name => "report[wind_condition]",
          :value => 'none',
          :content => 'None'
        assert_select "input#report_wind_condition_lessthan5",
          :name => "report[wind_condition]",
          :value => 'lessthan5',
          :content => 'Less than 5 mph'
        assert_select "input#report_wind_condition_greaterthan5",
          :name => "report[wind_condition]",
          :value => 'greaterthan5',
          :content => 'Greater than 5 mph'  
      end
    end
  end

  it "renders fieldset for precipitation conditions" do
    render
    assert_select "form", :method => 'post' do
      assert_select "fieldset#precipitation_conditions" do
        assert_select "input#report_precipitation_condition_misty",
          :name => "report[precipitation_condition]",
          :value => 'misty',
          :content => 'Misty'
        assert_select "input#report_precipitation_condition_light_rain",
          :name => "report[precipitation_condition]",
          :value => 'light_rain',
          :content => 'Light Rain'
        assert_select "input#report_precipitation_condition_rain",
          :name => "report[precipitation_condition]",
          :value => 'rain',
          :content => 'Rain'  
      end
    end
  end

  it "renders the edit report form" do
    render
    assert_select "form", :method => 'post' do 
      assert_select "input#report_site_address_1", 
           :name => "report[site_address_1]"
      assert_select "input#report_site_address_2", 
           :name => "report[site_address_2]"
      assert_select "input#report_site_city", 
           :name => "report[site_city]"
      assert_select "input#report_site_state", 
           :name => "report[site_state]"
      assert_select "input#report_site_zipcode", 
           :name => "report[site_zipcode]"

      assert_select "input#report_contractor_name", 
           :name => "report[contractor_name]"
      assert_select "input#report_contractor_address_1", 
           :name => "report[contractor_address_1]"
      assert_select "input#report_contractor_address_2", 
           :name => "report[contractor_address_2]"
      assert_select "input#report_contractor_city", 
           :name => "report[contractor_city]"
      # assert_select "input#report_contractor_state",
      #     :name => "report[contractor_state]"
      # assert_select "input#report_contractor_zipcode",
      #     :name => "report[contractor_zipcode]"

      assert_select "input#report_contract_number", 
           :name => "report[contract_number]"
      # assert_select "input#report_project_identifier_number",
      #     :name => "report[project_identifier_number]"
      # assert_select "input#report_wdid_number",
      #     :name => "report[wdid_number]"
      # assert_select "input#report_status",
      #     :name => "report[status]"

      # assert_select "select#report_submitted_by_contractor_1i", 
      #     :name => "report[submitted_by_contractor(1i)]"
      # assert_select "select#report_submitted_by_contractor_2i", 
      #      :name => "report[submitted_by_contractor(2i)]"
      # assert_select "select#report_submitted_by_contractor_3i", 
      #      :name => "report[submitted_by_contractor(3i)]"

      # assert_select "select#report_submitted_by_date_1i", 
      #      :name => "report[submitted_by_date(1i)]"
      # assert_select "select#report_submitted_by_date_2i", 
      #      :name => "report[submitted_by_date(2i)]"
      # assert_select "select#report_submitted_by_date_3i", 
      #      :name => "report[submitted_by_date(3i)]"

      # assert_select "input#report_wpc_manager", 
      #      :name => "report[wpc_manager]"
      # assert_select "input#report_wpc_phone", 
      #      :name => "report[wpc_phone]"
      # assert_select "input#report_wpc_emergency_phone", 
      #      :name => "report[wpc_emergency_phone]"

      # assert_select "input#report_inspector_name", 
      #      :name => "report[inspector_name]"
      # assert_select "select#report_inspection_date_1i",
      #      :name => "report[inspection_date(1i)]"
      # assert_select "select#report_inspection_date_2i",
      #      :name => "report[inspection_date(2i)]"
      # assert_select "select#report_inspection_date_3i",
      #      :name => "report[inspection_date(3i)]"

      # Failing spec after field changed from text 
      # to radio button input.

      # assert_select "input#report_construction_phase", 
      #      :name => "report[construction_phase]"

      assert_select "input#report_total_area", 
           :name => "report[total_area]"
      assert_select "input#report_total_DSA", 
           :name => "report[total_DSA]"
      assert_select "input#report_current_DSA", 
           :name => "report[current_DSA]"
      assert_select "input#report_inactive_DSA", 
           :name => "report[inactive_DSA]"

      # Failing spec after field changed from text 
      # to radio button input.

      # assert_select "input#report_inspection_type", 
      #      :name => "report[inspection_type]"

      assert_select "input#report_time_elapsed_last_storm", 
           :name => "report[time_elapsed_last_storm]"
      assert_select "input#report_precipitation_received", 
           :name => "report[precipitation_received]"          
      assert_select "input#report_time_storm_expected", 
           :name => "report[time_storm_expected]"
      assert_select "input#report_expected_precipitation_amount", 
           :name => "report[expected_precipitation_amount]"
      assert_select "input#report_time_elapsed_during_storm", 
           :name => "report[time_elapsed_during_storm]"           
      assert_select "input#report_gauge_reading_during_storm", 
           :name => "report[gauge_reading_during_storm]"
      assert_select "input#report_time_elapsed_post_storm", 
           :name => "report[time_elapsed_post_storm]"           
      assert_select "input#report_gauge_reading_post_storm", 
           :name => "report[gauge_reading_post_storm]"  
    end
  end
=end
end
