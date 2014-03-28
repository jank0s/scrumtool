class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :number
      t.date :start
      t.date :end
      t.integer :velocity
      t.integer :project_id

      t.timestamps
    end
  end
end
