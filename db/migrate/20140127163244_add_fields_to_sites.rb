class AddFieldsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :project_ea, :string
    add_column :sites, :wdid_number, :string
    add_column :sites, :construction_phase, :string
    add_column :sites, :contractor_name, :string
    add_column :sites, :contractor_address_1, :string
    add_column :sites, :contractor_address_2, :string
    add_column :sites, :contractor_city, :string
    add_column :sites, :contractor_state, :string
    add_column :sites, :contractor_zipcode, :string
    add_column :sites, :contract_number, :string
    add_column :sites, :wpcm_name, :string
    add_column :sites, :wpcm_company, :string
    add_column :sites, :wpcm_phone, :string
    add_column :sites, :wpcm_emergency_phone, :string
    add_column :sites, :qsp_name, :string
    add_column :sites, :qsp_company, :string
    add_column :sites, :qsp_phone, :string
    add_column :sites, :qsp_emergency_phone, :string
    add_column :sites, :total_area, :decimal
    add_column :sites, :total_dsa, :decimal
    add_column :sites, :current_dsa, :decimal
    add_column :sites, :inactive_dsa, :decimal
    add_column :sites, :time_since_last_storm, :string
    add_column :sites, :precipitation_received, :decimal
    add_column :sites, :permits, :string
    add_column :sites, :resident_engineer_name, :string
    add_column :sites, :structures_representative_name, :string
    add_column :sites, :last_bmp_status, :date
    add_column :sites, :last_inspection, :date
    add_column :sites, :last_corrective_action, :date
    add_column :sites, :last_reap, :date
    add_column :sites, :last_training, :date
    add_column :sites, :last_weather_forecast, :date
    add_column :sites, :last_sampling, :date
  end
end
