FactoryGirl.define do
  factory :report do
  	site_information_name "MSN-A1"
  	site_address_1 "320 Deere Island Lane"
  	site_address_2 ""
  	site_city "Novato"
  	site_state "CA"
  	site_zipcode 94945

  	contractor_name "GBI"
  	contractor_address_1 "525 Jacoby Street"
  	contractor_address_2 "N/A"
  	contractor_city " San Rafael"
  	contactor_state "CA"
  	contactor_zipcode 94901

  	contract_number "04-264064"
  	project_identifer_number "000010"
  	wdid_number "000020"
  	status "Active"

  	# submitted_by_contractor "4-1-12"
  	# submitted_by_date "4-1-12"

  	wpc_manager "Tom Barr - GBI"
  	wpc_phone "415-760-9011"
  	wpc_emergency_phone "911"

  	inspector_name "Mark Casarotti"
  	inspection_date "4-1-12"

  	weather_condition "Clear" 
  	precipitation_condition "None"
  	wind_condition "Less than 5 mph"

  	construction_phase "Highway Construction"

  	total_area "20 acres"
  	total_DSA "5 acres"
  	current_DSA "3 acres"
  	inactive_DSA "2 acres"

  	inspection_type "Weekly"

	  time_elapsed_last_storm "5 days" 
	  precipitation_received "2 inches"
  	time_storm_expected "N/A"
  	expected_precipitation_amount "N/A"
  	time_elapsed_during_storm "N/A"
  	gauge_reading_during_storm "N/A"
  	time_elapsed_post_storm "N/A"
  	gauge_reading_post_storm "N/A"
  end
end
