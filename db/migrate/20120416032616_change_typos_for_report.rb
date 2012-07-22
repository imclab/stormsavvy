class ChangeTyposForReport < ActiveRecord::Migration
  def change
    # Fixing typos in AddFieldsToReport migration file

    # Comment out remove_column - fails heroku deployment

    # remove_column :reports, :water_polution_control_manager_name, 	:string
    add_column :reports, :water_pollution_control_manager_name, 	:string

    # remove_column :reports, :water_polution_control_manager_company_name, :string
    add_column :reports, :water_pollution_control_manager_company_name,   :string

    # remove_column :reports, :water_polution_control_manager_phone_number, :string
    add_column :reports, :water_pollution_control_manager_phone_number,   :string

    # remove_column :reports, :water_polution_control_manager_emergency_phone_number, :string
    add_column :reports, :water_pollution_control_manager_emergency_phone_number,   :string

    # remove_column :reports, :storm_information_expected_precipitaion_amount, :decimal
    add_column :reports, :storm_information_expected_precipitation_amount,   :decimal

    # remove_column :reports, :storm_information_percipitation_amount_from_last_form, :decimal
    add_column :reports, :storm_information_precipitation_amount_from_last_form,    :decimal
  end
end
