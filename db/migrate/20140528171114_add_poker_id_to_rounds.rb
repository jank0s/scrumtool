class AddPokerIdToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :poker_id, :integer
  end
end
