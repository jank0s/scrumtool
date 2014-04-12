class AddNoteToStories < ActiveRecord::Migration
  def change
    add_column :stories, :note, :text
  end
end
