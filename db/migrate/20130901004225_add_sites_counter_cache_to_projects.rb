class AddSitesCounterCacheToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :sites_count, :integer, default: 0, null: false
    Project.reset_column_information
    Project.find(:all).each do |p|
        Project.update_counters p.id, :sites_count => p.sites.length
      end
  end
end
