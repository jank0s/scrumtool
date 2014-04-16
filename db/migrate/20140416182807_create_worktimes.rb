class CreateWorktimes < ActiveRecord::Migration
  def change
    create_table :worktimes do |t|
      t.datetime :startwork
      t.datetime :endwork

      t.timestamps
    end
  end
end
