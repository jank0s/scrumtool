class AddStoryIdToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :story_id, :integer
  end
end
