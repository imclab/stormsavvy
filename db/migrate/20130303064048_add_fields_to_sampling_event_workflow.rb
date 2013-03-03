class AddFieldsToSamplingEventWorkflow < ActiveRecord::Migration
  def change
    add_column :sampling_event_workflows, :hours_before_rain, :integer
    add_column :sampling_event_workflows, :cem2051, :boolean
    add_column :sampling_event_workflows, :cem2052, :boolean
    add_column :sampling_event_workflows, :ph_sample, :boolean
    add_column :sampling_event_workflows, :turbidity, :boolean
    add_column :sampling_event_workflows, :report_sent, :boolean
    add_column :sampling_event_workflows, :report_received, :boolean
    add_column :sampling_event_workflows, :chance_of_rain, :integer
    add_column :sampling_event_workflows, :amount_of_rain, :float
    add_column :sampling_event_workflows, :forecast_rain, :float
    add_column :sampling_event_workflows, :sampling_event, :boolean
  end
end
