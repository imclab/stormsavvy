class AddFieldsToInspectionEvents < ActiveRecord::Migration
  def change
    # add_column :inspection_events, :site_id,                :integer
    add_column :inspection_events, :inspection_type,        :string
    add_column :inspection_events, :inspection_description, :text
    add_column :inspection_events, :inspection_date,        :datetime
    add_column :inspection_events, :submitted_by,           :string
    add_column :inspection_events, :inspected_by,           :string
=begin
    # use this if running migrations for first time
    create_table :inspection_events do |t|
      t.integer :site_id
      t.string :inspection_type
      t.text :inspection_description
      t.datetime :inspection_date
      t.string :submitted_by
      t.string :inspected_by

      t.timestamps
    end
=end
  end
end
