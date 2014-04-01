class AddActiveProjectId < ActiveRecord::Migration
  def change
      add_column :users, :activeproject_id, :integer
  end
end
