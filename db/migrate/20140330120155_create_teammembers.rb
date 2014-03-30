class CreateTeammembers < ActiveRecord::Migration
  def change
    create_table :teammembers do |t|

      t.timestamps
    end
  end
end
