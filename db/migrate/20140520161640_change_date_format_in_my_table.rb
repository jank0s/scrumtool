class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
  	  	change_column :comments, :user_id, :integer
  		change_column :comments, :project_id, :integer

  end
end
