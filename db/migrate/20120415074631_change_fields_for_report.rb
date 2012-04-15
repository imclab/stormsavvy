class ChangeFieldsForReport < ActiveRecord::Migration
  def change

	add_column :reports, :submitted_by_contractor, 	:date
	add_column :reports, :submitted_by_date,	   	:date

	add_column :reports, :wpc_manager,			 	:string	 
	add_column :reports, :wpc_phone,				:string
	add_column :reports, :wpc_emergency_phone,	 	:string

	add_column :reports, :inspector_name,			:string
	add_column :reports, :inspection_date,		 	:date

	add_column :reports, :weather_condition, 		:string
	add_column :reports, :precipitation_condition,  :string
	add_column :reports, :wind_condition,			:string

	add_column :reports, :construction_phase,		:string
	add_column :reports, :total_area, 			 	:decimal
	add_column :reports, :total_DSA, 				:decimal
	add_column :reports, :current_DSA, 			 	:decimal
	add_column :reports, :inactive_DSA,			 	:decimal

	add_column :reports, :inspection_type,		 		 :string
	add_column :reports, :time_elapsed_last_storm, 		 :decimal
	add_column :reports, :precipitation_received,  		 :decimal
	add_column :reports, :time_storm_expected,  		 :decimal
	add_column :reports, :expected_precipitation_amount, :decimal
	add_column :reports, :time_elapsed_during_storm,  	 :decimal
	add_column :reports, :gauge_reading_during_storm, 	 :decimal
	add_column :reports, :time_elapsed_post_storm, 		 :decimal
	add_column :reports, :gauge_reading_post_storm, 	 :decimal
  end
end
