class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :string
      t.string :story_id
      t.string :integer
      t.string :assigned_to
      t.string :integer

      t.timestamps
    end
  end
end
