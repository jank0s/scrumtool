class CreateProductowners < ActiveRecord::Migration
  def change
    create_table :productowners do |t|

      t.timestamps
    end
  end
end
