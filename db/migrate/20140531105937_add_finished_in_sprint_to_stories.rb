class AddFinishedInSprintToStories < ActiveRecord::Migration
  def change
    add_column :stories, :finished_in_sprint, :integer
  end
end
