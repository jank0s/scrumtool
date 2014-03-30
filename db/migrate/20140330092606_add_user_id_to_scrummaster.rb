class AddUserIdToScrummaster < ActiveRecord::Migration
  def change
    add_column :scrummasters, :user_id, :integer
  end
end
