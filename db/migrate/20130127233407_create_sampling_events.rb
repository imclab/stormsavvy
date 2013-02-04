class CreateSamplingEvents < ActiveRecord::Migration
  def change
    create_table :sampling_events do |t|
      t.integer :site_id
      t.string :sampling_type
      t.text :sampling_description
      t.datetime :sampling_date
      t.string :submitted_by
      t.string :sampled_by
      t.integer :sample_id_1
      t.string :sample_location_1
      t.time :sample_time_1
      t.string :analysis_type_1
      t.string :analysis_result_1
      t.string :analysis_average_1
      t.integer :sample_id_2
      t.string :sample_location_2
      t.time :sample_time_2
      t.string :analysis_type_2
      t.string :analysis_result_2
      t.string :analysis_average_2
      t.integer :sample_id_3
      t.string :sample_location_3
      t.time :sample_time_3
      t.string :analysis_type_3
      t.string :analysis_result_3
      t.string :analysis_average_3
      t.integer :sample_id_4
      t.string :sample_location_4
      t.time :sample_time_4
      t.string :analysis_type_4
      t.string :analysis_result_4
      t.string :analysis_average_4
      t.integer :sample_id_5
      t.string :sample_location_5
      t.time :sample_time_5
      t.string :analysis_type_5
      t.string :analysis_result_5
      t.string :analysis_average_5

      t.timestamps
    end
  end
end
