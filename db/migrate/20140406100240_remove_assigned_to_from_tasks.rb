class RemoveAssignedToFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :assigned_to, :string
  end
end
