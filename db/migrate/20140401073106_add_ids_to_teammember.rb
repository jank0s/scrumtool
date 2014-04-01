class AddIdsToTeammember < ActiveRecord::Migration
    def change
        add_column :teammembers, :project_id, :integer
        add_column :teammembers, :user_id, :integer
    end
end
