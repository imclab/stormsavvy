class FixReportFieldTypos < ActiveRecord::Migration
  def change
    # Fixing typos in AddFieldsToReport migration file
    remove_column :reports, :contactor_state,    :string
    remove_column :reports, :contactor_zipcode,  :integer
    add_column    :reports, :contractor_state,   :string
    add_column    :reports, :contractor_zipcode, :integer

  #   remove_column :reports, :water_polution_control_manager_emergancy_phone_number, :string
  #   add_column    :reports, :water_polution_control_manager_emergency_phone_number, :string

  #   remove_column :reports, :storm_information_expected_percipitaion_amount, :decimal
  #   add_column    :reports, :storm_information_expected_precipitaion_amount, :decimal

  #   remove_column :reports, :storm_information_percipitation_since_last_storm, :decimal
  #   remove_column :reports, :storm_information_precipitation_since_last_storm, :decimal
  end
end
