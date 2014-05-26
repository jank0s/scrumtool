class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :sprint_id
      t.float :estimation

      t.timestamps
    end
  end
end
