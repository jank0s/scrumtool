class CreateWorktimes < ActiveRecord::Migration
  def change
    create_table :worktimes do |t|
      t.datetime :start
      t.float :done
      t.float :remaining
      t.date :day
      t.integer :task_id

      t.timestamps
    end
  end
end
