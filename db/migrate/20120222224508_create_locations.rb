class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :zipcode
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
