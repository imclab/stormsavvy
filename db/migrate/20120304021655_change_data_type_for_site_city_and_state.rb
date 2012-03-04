class ChangeDataTypeForSiteCityAndState < ActiveRecord::Migration
  def up
    change_table :sites do |t|
      t.change :city, :string
      t.change :state, :string
    end
  end

  def down
    change_table :sites do |t|
      t.change :city, :integer
      t.change :state, :integer
    end
  end
end
