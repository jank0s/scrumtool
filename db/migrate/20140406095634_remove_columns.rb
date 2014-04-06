class RemoveColumns < ActiveRecord::Migration
  def change

  end
  def self.up
  	remove_column :tasks, :string
  	remove_column :tasks, :story_id
  	remove_column :tasks, :integer
  	remove_column :tasks, :assigned_to
  end
  def self.down
  	add_column :task, :story_id, :integer
  	add_column :task, :assigned_to, :integer

  end
end
