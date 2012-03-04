class AddRiskLevelToSites < ActiveRecord::Migration
  def change
    add_column :sites, :risk_level, :string

  end
end
