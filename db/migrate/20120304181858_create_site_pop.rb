class CreateSitePop < ActiveRecord::Migration
  def change
    create_table :site_pops do |t|
      t.datetime :date
      t.integer :pop
      t.integer :site_id

      t.timestamps
    end
  end
end
