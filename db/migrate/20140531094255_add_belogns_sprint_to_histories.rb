class AddBelognsSprintToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :belongs_sprint, :boolean
  end
end
