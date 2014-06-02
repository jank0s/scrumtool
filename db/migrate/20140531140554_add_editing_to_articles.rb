class AddEditingToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :editing, :boolean
  end
end
