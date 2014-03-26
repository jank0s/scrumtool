class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.integer :scrummaster_id
      t.integer :productowner_id

      t.timestamps
    end
  end
end
