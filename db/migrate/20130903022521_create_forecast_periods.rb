class CreateForecastPeriods < ActiveRecord::Migration
  def change
    create_table :forecast_periods do |t|
      t.datetime :forecast_prediction_time
      t.integer :temperature
      t.integer :dewpoint
      t.integer :rh
      t.integer :sky_cover
      t.integer :wind_speed
      t.integer :wind_direction
      t.integer :wind_gust
      t.integer :pop
      t.float :qpf
      t.float :snow_amount
      t.integer :snow_level
      t.string :wx
      t.belongs_to :site
      t.belongs_to :weather_update

      t.timestamps
    end
    add_index :forecast_periods, :site_id
    add_index :forecast_periods, :weather_update_id
  end
end
