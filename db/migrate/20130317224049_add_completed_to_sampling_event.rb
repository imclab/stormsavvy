class AddCompletedToSamplingEvent < ActiveRecord::Migration
  def change
    add_column :sampling_events, :completed, :boolean
  end
end
