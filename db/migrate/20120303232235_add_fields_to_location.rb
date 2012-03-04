class AddFieldsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :address_1, :string
    add_column :locations, :address_2, :string
    add_column :locations, :city, :string
    add_column :locations, :state, :string
  end
end
