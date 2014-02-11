class AddForecastToSites < ActiveRecord::Migration
  def change
    add_column :sites, :noaa_forecast, :text
    add_column :sites, :wg_forecast, :text
  end
end
