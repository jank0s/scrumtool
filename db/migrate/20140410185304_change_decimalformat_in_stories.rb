class ChangeDecimalformatInStories < ActiveRecord::Migration
  def up
   change_column :stories, :timeestimates, :float
  end

  def down
   change_column :stories, :timeestimates, :decimal
  end
end
