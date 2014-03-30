class RemoveUserIdFromScrummasters < ActiveRecord::Migration
  def change
    remove_column :scrummasters, :user_id, :integer
  end
end
