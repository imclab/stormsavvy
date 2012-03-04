class AddFieldsToReport < ActiveRecord::Migration
  def change
    ## First Page of CEM2030 Report
    add_column :reports, :project_id, :string

    add_column :reports, :site_information_name,    :string
    add_column :reports, :site_address_1,           :string
    add_column :reports, :site_address_2,           :string
    add_column :reports, :site_city,                :string
    add_column :reports, :site_state,               :string
    add_column :reports, :site_zipcode,             :integer

    add_column :reports, :contractor_name,          :string
    add_column :reports, :contractor_address_1,     :string
    add_column :reports, :contractor_address_2,     :string
    add_column :reports, :contractor_city,          :string
    add_column :reports, :contactor_state,          :string
    add_column :reports, :contactor_zipcode,        :integer

    add_column :reports, :contract_number,          :string
    add_column :reports, :project_identifer_number, :string
    add_column :reports, :wdid_number,              :string

    add_column :reports, :project_risk_level,       :integer

    add_column :reports, :water_polution_control_manager_name,                   :string
    add_column :reports, :water_polution_control_manager_company_name,           :string
    add_column :reports, :water_polution_control_manager_phone_number,           :string
    add_column :reports, :water_polution_control_manager_emergancy_phone_number, :string

    add_column :reports, :inspector_name,     :string
    add_column :reports, :date_of_inspection, :date

    add_column :reports, :weather_condition,       :string
    add_column :reports, :precipitation_condition, :string
    add_column :reports, :wind_condition,          :string

    add_column :reports, :construction_phase, :string

    add_column :reports, :site_information_acres_total_project_area,                         :decimal
    add_column :reports, :site_information_acres_total_project_disturbed_soil_area,          :decimal
    add_column :reports, :site_information_acres_current_phase_disturbed_soil_area,          :decimal
 
    add_column :reports, :inspection_type, :string

    add_column :reports, :storm_information_time_elapsed_since_last_storm,  :string
    add_column :reports, :storm_information_percipitation_since_last_storm, :decimal

    add_column :reports, :storm_information_time_storm_is_expected,         :datetime
    add_column :reports, :storm_information_time_elapsed_since_storm_began, :decimal
    add_column :reports, :storm_information_time_elapsed_since_storm,       :decimal

    add_column :reports, :storm_information_percipitation_amount_from_last_form, :decimal
    add_column :reports, :storm_information_expected_percipitaion_amount,        :decimal

  end
end
