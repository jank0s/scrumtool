class AddStoryIdToWorktimes < ActiveRecord::Migration
  def change
    add_column :worktimes, :story_id, :integer
  end
end
