class RemoveIntegerFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :integer, :string
  end
end
