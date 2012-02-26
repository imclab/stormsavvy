class AddZipIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :zipcode
  end
end
