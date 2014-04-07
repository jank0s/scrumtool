class RemoveNumberFromSprints < ActiveRecord::Migration
  def change
    remove_column :sprints, :number, :integer
  end
end
