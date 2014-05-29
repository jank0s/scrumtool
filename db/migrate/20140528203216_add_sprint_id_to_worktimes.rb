class AddSprintIdToWorktimes < ActiveRecord::Migration
  def change
    add_column :worktimes, :sprint_id, :integer
  end
end
