class AddSiteIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :site_id, :integer

  end
end
