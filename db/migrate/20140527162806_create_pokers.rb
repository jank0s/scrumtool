class CreatePokers < ActiveRecord::Migration
  def change
    create_table :pokers do |t|

      t.timestamps
    end
  end
end
