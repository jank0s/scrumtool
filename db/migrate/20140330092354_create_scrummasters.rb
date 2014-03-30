class CreateScrummasters < ActiveRecord::Migration
  def change
    create_table :scrummasters do |t|

      t.timestamps
    end
  end
end
