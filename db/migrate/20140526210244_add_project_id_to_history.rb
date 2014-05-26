class AddProjectIdToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :project_id, :integer
  end
end
