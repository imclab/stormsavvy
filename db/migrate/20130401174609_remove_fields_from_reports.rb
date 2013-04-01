class RemoveFieldsFromReports < ActiveRecord::Migration
  def up
    remove_column :reports, :type
    remove_column :reports, :site_information_name
    remove_column :reports, :site_address_1
    remove_column :reports, :site_address_2
    remove_column :reports, :site_city
    remove_column :reports, :site_state
    remove_column :reports, :site_zipcode
    remove_column :reports, :contractor_name
    remove_column :reports, :contractor_address_1
    remove_column :reports, :contractor_address_2
    remove_column :reports, :contractor_city
    remove_column :reports, :contactor_state
    remove_column :reports, :contactor_zipcode
    remove_column :reports, :contract_number
    remove_column :reports, :project_identifer_number
    remove_column :reports, :wdid_number
    remove_column :reports, :project_risk_level
    remove_column :reports, :water_polution_control_manager_name
    remove_column :reports, :water_polution_control_manager_company_name
    remove_column :reports, :water_polution_control_manager_phone_number
    remove_column :reports, :water_polution_control_manager_emergancy_phone_number
    remove_column :reports, :inspector_name
    remove_column :reports, :date_of_inspection
    remove_column :reports, :weather_condition
    remove_column :reports, :precipitation_condition
    remove_column :reports, :wind_condition
    remove_column :reports, :construction_phase
    remove_column :reports, :site_information_acres_total_project_area
    remove_column :reports, :site_information_acres_total_project_disturbed_soil_area
    remove_column :reports, :site_information_acres_current_phase_disturbed_soil_area
    remove_column :reports, :storm_information_time_elapsed_since_last_storm
    remove_column :reports, :storm_information_percipitation_since_last_storm
    remove_column :reports, :storm_information_time_storm_is_expected
    remove_column :reports, :storm_information_time_elapsed_since_storm_began
    remove_column :reports, :storm_information_time_elapsed_since_storm
    remove_column :reports, :storm_information_percipitation_amount_from_last_form
    remove_column :reports, :storm_information_expected_percipitaion_amount
    remove_column :reports, :submitted_by_contractor
    remove_column :reports, :submitted_by_date
    remove_column :reports, :wpc_manager
    remove_column :reports, :wpc_phone
    remove_column :reports, :wpc_emergency_phone
    remove_column :reports, :inspection_date
    remove_column :reports, :total_area
    remove_column :reports, :total_DSA
    remove_column :reports, :current_DSA
    remove_column :reports, :inactive_DSA
    remove_column :reports, :time_elapsed_last_storm
    remove_column :reports, :precipitation_received
    remove_column :reports, :time_storm_expected
    remove_column :reports, :expected_precipitation_amount
    remove_column :reports, :time_elapsed_during_storm
    remove_column :reports, :gauge_reading_during_storm
    remove_column :reports, :time_elapsed_post_storm
    remove_column :reports, :gauge_reading_post_storm
    remove_column :reports, :contractor_state
    remove_column :reports, :contractor_zipcode
    remove_column :reports, :water_polution_control_manager_emergency_phone_number
    remove_column :reports, :storm_information_expected_precipitaion_amount
    remove_column :reports, :water_pollution_control_manager_name
    remove_column :reports, :water_pollution_control_manager_company_name
    remove_column :reports, :water_pollution_control_manager_phone_number
    remove_column :reports, :water_pollution_control_manager_emergency_phone_number
    remove_column :reports, :storm_information_expected_precipitation_amount
    remove_column :reports, :storm_information_precipitation_amount_from_last_form
    remove_column :reports, :project_identifier_number
  end

  def down
    add_column :reports, :project_identifier_number, :string
    add_column :reports, :storm_information_precipitation_amount_from_last_form, :decimal
    add_column :reports, :storm_information_expected_precipitation_amount, :decimal
    add_column :reports, :water_pollution_control_manager_emergency_phone_number, :string
    add_column :reports, :water_pollution_control_manager_phone_number, :string
    add_column :reports, :water_pollution_control_manager_company_name, :string
    add_column :reports, :water_pollution_control_manager_name, :string
    add_column :reports, :storm_information_expected_precipitaion_amount, :decimal
    add_column :reports, :water_polution_control_manager_emergency_phone_number, :string
    add_column :reports, :contractor_zipcode, :integer
    add_column :reports, :contractor_state, :string
    add_column :reports, :gauge_reading_post_storm, :decimal
    add_column :reports, :time_elapsed_post_storm, :decimal
    add_column :reports, :gauge_reading_during_storm, :decimal
    add_column :reports, :time_elapsed_during_storm, :decimal
    add_column :reports, :expected_precipitation_amount, :decimal
    add_column :reports, :time_storm_expected, :decimal
    add_column :reports, :precipitation_received, :decimal
    add_column :reports, :time_elapsed_last_storm, :decimal
    add_column :reports, :inactive_DSA, :decimal
    add_column :reports, :current_DSA, :decimal
    add_column :reports, :total_DSA, :decimal
    add_column :reports, :total_area, :decimal
    add_column :reports, :inspection_date, :date
    add_column :reports, :wpc_emergency_phone, :string
    add_column :reports, :wpc_phone, :string
    add_column :reports, :wpc_manager, :string
    add_column :reports, :submitted_by_date, :date
    add_column :reports, :submitted_by_contractor, :date
    add_column :reports, :storm_information_expected_percipitaion_amount, :decimal
    add_column :reports, :storm_information_percipitation_amount_from_last_form, :decimal
    add_column :reports, :storm_information_time_elapsed_since_storm, :decimal
    add_column :reports, :storm_information_time_elapsed_since_storm_began, :decimal
    add_column :reports, :storm_information_time_storm_is_expected, :datetime
    add_column :reports, :storm_information_percipitation_since_last_storm, :decimal
    add_column :reports, :storm_information_time_elapsed_since_last_storm, :string
    add_column :reports, :site_information_acres_current_phase_disturbed_soil_area, :decimal
    add_column :reports, :site_information_acres_total_project_disturbed_soil_area, :decimal
    add_column :reports, :site_information_acres_total_project_area, :decimal
    add_column :reports, :construction_phase, :string
    add_column :reports, :wind_condition, :string
    add_column :reports, :precipitation_condition, :string
    add_column :reports, :weather_condition, :string
    add_column :reports, :date_of_inspection, :date
    add_column :reports, :inspector_name, :string
    add_column :reports, :water_polution_control_manager_emergancy_phone_number, :string
    add_column :reports, :water_polution_control_manager_phone_number, :string
    add_column :reports, :water_polution_control_manager_company_name, :string
    add_column :reports, :water_polution_control_manager_name, :string
    add_column :reports, :project_risk_level, :integer
    add_column :reports, :wdid_number, :string
    add_column :reports, :project_identifer_number, :string
    add_column :reports, :contract_number, :string
    add_column :reports, :contactor_zipcode, :integer
    add_column :reports, :contactor_state, :string
    add_column :reports, :contractor_city, :string
    add_column :reports, :contractor_address_2, :string
    add_column :reports, :contractor_address_1, :string
    add_column :reports, :contractor_name, :string
    add_column :reports, :site_zipcode, :integer
    add_column :reports, :site_state, :string
    add_column :reports, :site_city, :string
    add_column :reports, :site_address_2, :string
    add_column :reports, :site_address_1, :string
    add_column :reports, :site_information_name, :string
    add_column :reports, :type, :string
  end
end
