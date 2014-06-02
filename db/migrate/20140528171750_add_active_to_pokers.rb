class AddActiveToPokers < ActiveRecord::Migration
  def change
    add_column :pokers, :active, :boolean
  end
end
