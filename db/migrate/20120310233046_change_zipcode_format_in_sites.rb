class ChangeZipcodeFormatInSites < ActiveRecord::Migration
  def up
    change_column :sites, :zipcode, :string
  end

  def down
    change_column :sites, :zipcode, :integer
  end
end
