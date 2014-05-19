class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :value
      t.string :user_id
      t.string :integer
      t.string :project_id
      t.string :integer

      t.timestamps
    end
  end
end
