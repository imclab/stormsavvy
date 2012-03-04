class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :contractor_name,          :string
    add_column :users, :contractor_address_1,     :string
    add_column :users, :contractor_address_2,     :string
    add_column :users, :contractor_city,          :string
    add_column :users, :contactor_state,          :string
    add_column :users, :contactor_zipcode,        :integer
  end
end
