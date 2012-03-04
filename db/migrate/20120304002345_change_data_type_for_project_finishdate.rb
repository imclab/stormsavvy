class ChangeDataTypeForProjectFinishdate < ActiveRecord::Migration
  def up
    change_table :projects do |t|
      t.change :finishdate, :date
    end
  end

  def down
    change_table :projects do |t|
      t.change :finishdate, :datetime
    end
  end
end
