class CreateWeatherEvents < ActiveRecord::Migration
  def change
    create_table :weather_events do |t|
      t.integer :site_id
      t.datetime :eventdate
      t.float :duration
      t.float :rainfall
      t.boolean :inspected
      t.boolean :qualifying

      t.timestamps
    end
  end
end
