class ChangeZipcodeFormatInUsers < ActiveRecord::Migration
  def up
    change_column :users, :contractor_zipcode, :string
  end

  def down
    change_column :users, :contractor_zipcode, :integer
  end
end
