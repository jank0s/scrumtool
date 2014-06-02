class AddTaskEstimationToWorktimes < ActiveRecord::Migration
  def change
    add_column :worktimes, :task_estimation, :float
  end
end
