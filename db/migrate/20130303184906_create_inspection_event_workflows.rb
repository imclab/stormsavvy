class CreateInspectionEventWorkflows < ActiveRecord::Migration
  def change
    create_table :inspection_event_workflows do |t|
      t.integer :hours_before_rain
      t.boolean :reap
      t.boolean :cem2023
      t.boolean :cem2024
      t.boolean :cem2034
      t.boolean :cem2035
      t.boolean :cem2040
      t.boolean :pre_storm_inspection
      t.boolean :during_storm_inspection
      t.boolean :post_storm_inspection
      t.boolean :report_sent
      t.boolean :report_received
      t.boolean :ph_sample
      t.boolean :turbidity
      t.boolean :notice_of_discharge
      t.boolean :quarterly_inspction
      t.integer :chance_of_rain
      t.float :amount_of_rain
      t.float :forecast_rain
      t.boolean :inspection_event

      t.timestamps
    end
  end
end
