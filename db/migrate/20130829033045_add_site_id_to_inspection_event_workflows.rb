class AddSiteIdToInspectionEventWorkflows < ActiveRecord::Migration
  def change
    add_column :inspection_event_workflows, :site_id, :integer
  end
end
