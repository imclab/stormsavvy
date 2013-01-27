class CreateInspectionEvents < ActiveRecord::Migration
  def change
    create_table :inspection_events do |t|
      t.integer :site_id
      t.string :inspection_type
      t.text :inspection_description
      t.datetime :inspection_date
      t.string :submitted_by
      t.string :inspected_by

      t.timestamps
    end
  end
end
