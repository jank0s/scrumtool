class AddValueToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :value, :float
  end
end
