class RemoveEndworkDateFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :endwork_date, :datetime
  end
end
