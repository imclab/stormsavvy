class ChangeDataTypeForSiteAddresses < ActiveRecord::Migration
  def up
    change_table :sites do |t|
      t.change :address_1, :string
      t.change :address_2, :string
    end
  end

  def down
    change_table :sites do |t|
      t.change :address_1, :integer
      t.change :address_2, :integer
    end
  end
end
