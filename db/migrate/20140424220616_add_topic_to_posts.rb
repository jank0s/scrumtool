class AddTopicToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic, :string
  end
end
