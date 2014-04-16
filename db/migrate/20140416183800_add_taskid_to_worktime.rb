class AddTaskidToWorktime < ActiveRecord::Migration
  def change
    add_column :worktimes, :task_id, :integer
  end
end
