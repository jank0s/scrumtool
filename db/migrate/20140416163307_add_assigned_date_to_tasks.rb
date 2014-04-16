class AddAssignedDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_date, :datetime
  end
end
