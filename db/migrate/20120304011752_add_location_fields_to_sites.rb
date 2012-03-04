class AddLocationFieldsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :zipcode, :integer
    add_column :sites, :lat, :float
    add_column :sites, :long, :float
    add_column :sites, :address_1, :integer
    add_column :sites, :address_2, :integer
    add_column :sites, :city, :integer
    add_column :sites, :state, :integer
  end
end
