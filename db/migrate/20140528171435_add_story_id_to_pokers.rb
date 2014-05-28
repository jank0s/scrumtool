class AddStoryIdToPokers < ActiveRecord::Migration
  def change
    add_column :pokers, :story_id, :integer
  end
end
