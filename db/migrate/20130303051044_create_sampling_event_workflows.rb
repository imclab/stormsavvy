class CreateSamplingEventWorkflows < ActiveRecord::Migration
  def change
    create_table :sampling_event_workflows do |t|

      t.timestamps
    end
  end
end
