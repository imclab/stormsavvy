class AddStatusToInspectionEvent < ActiveRecord::Migration
  def change
    add_column :inspection_events, :status, :string
  end
end
