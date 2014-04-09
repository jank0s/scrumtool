class AddProposedIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :proposed_id, :integer
  end
end
