class RemoveStringFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :string, :string
  end
end
