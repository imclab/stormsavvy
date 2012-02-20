class CreateInspectionEvents < ActiveRecord::Migration
  def change
    create_table :inspection_events do |t|
      t.integer :site_id
      t.string :type
      t.text :description
      t.datetime :date
      t.datetime :submitted

      t.timestamps
    end
  end
end
