class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :project_id
      t.string :name
      t.text :description
      t.text :test
      t.integer :priority_id
      t.integer :value
      t.boolean :finished

      t.timestamps
    end
  end
end
