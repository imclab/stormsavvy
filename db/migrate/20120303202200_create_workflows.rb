class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.integer :hours_before_rain
      t.boolean :reap
      t.boolean :cem2030
      t.boolean :ph_sample
      t.boolean :turbidity
      t.boolean :report_sent
      t.boolean :report_received

      t.timestamps
    end
  end
end
