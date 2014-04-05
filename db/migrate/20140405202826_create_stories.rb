class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.text :test
      t.integer :priority
      t.integer :value

      t.timestamps
    end
  end
end
