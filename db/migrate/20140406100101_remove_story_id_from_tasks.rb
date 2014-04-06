class RemoveStoryIdFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :story_id, :string
  end
end
