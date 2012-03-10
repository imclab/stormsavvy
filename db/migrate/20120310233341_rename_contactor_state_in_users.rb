class RenameContactorStateInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :contactor_state, :contractor_state
    rename_column :users, :contactor_zipcode, :contractor_zipcode
  end
end
