class RemoveIntegerFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :integer, :string
  end
end
