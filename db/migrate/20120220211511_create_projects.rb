class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.datetime :startdate
      t.datetime :finishdate
      t.boolean :active

      t.timestamps
    end
  end
end
