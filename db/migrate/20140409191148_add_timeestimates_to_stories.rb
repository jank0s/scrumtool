class AddTimeestimatesToStories < ActiveRecord::Migration
  def change
    add_column :stories, :timeestimates, :decimal
  end
end
