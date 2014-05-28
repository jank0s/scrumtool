class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.float :value

      t.timestamps
    end
  end
end
