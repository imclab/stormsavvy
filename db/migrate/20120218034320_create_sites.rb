class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :description
      t.string :costcode
      t.string :size
      t.string :exposed_area
      t.string :location

      t.timestamps
    end
  end
end
