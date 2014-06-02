class CreateWorkloads < ActiveRecord::Migration
  def change
    create_table :workloads do |t|
      t.integer :sprint_id
      t.float :estimation
      t.integer :project_id
      t.integer :story_id

      t.timestamps
    end
  end
end
