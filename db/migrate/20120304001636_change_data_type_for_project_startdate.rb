class ChangeDataTypeForProjectStartdate < ActiveRecord::Migration
  def up
    change_table :projects do |t|
      t.change :startdate, :date
    end
  end

  def down
    change_table :projects do |t|
      t.change :startdate, :datetime
    end
  end
end
