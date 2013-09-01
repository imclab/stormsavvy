class AddLatAndLonToSites < ActiveRecord::Migration
  def change
    remove_column :sites, :lat
    remove_column :sites, :long

    add_column :sites, :lat, :float, default: 0, null: false
    add_column :sites, :lng, :float, default: 0, null: false

    Site.find_in_batches do |sites|
      sites.each do |site|
        site.save_geo_coordinates
      end
    end
  end
end
