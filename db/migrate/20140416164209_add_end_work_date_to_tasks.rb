class AddEndWorkDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :endwork_date, :datetime
  end
end
