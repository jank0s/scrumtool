class RemoveStartworkDateFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :startwork_date, :datetime
  end
end
