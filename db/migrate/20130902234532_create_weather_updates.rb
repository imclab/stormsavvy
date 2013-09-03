class CreateWeatherUpdates < ActiveRecord::Migration
  def change
    create_table :weather_updates do |t|
      t.belongs_to :site
      t.datetime :forecast_creation_time
      t.float :lat
      t.float :lng
      t.integer :elevation
      t.integer :duration
      t.integer :interval

      t.timestamps
    end
    add_index :weather_updates, :site_id
  end
end
