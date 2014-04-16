class AddStartWorkDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :startwork_date, :datetime
  end
end
