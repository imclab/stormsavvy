class AddStatusToSamplingEvent < ActiveRecord::Migration
  def change
    add_column :sampling_events, :status, :boolean
  end
end
