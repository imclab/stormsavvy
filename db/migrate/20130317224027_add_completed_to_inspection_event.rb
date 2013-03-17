class AddCompletedToInspectionEvent < ActiveRecord::Migration
  def change
    add_column :inspection_events, :completed, :boolean
  end
end
