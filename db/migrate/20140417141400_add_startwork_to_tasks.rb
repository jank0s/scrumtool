class AddStartworkToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :startwork, :datetime
  end
end
