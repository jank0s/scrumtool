class ChangeDecimalFormatInStories < ActiveRecord::Migration
   def up
   change_column :stories, :timeestimates, :decimal
  end

  def down
   change_column :stories, :timeestimates, :float
  end
end
