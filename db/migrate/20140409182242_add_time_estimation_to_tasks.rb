class AddTimeEstimationToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :time_estimation, :float
  end
end
