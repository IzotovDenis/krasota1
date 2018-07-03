class AddLikesCounterToUsersAndItems < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :likes_counter, :integer, default: 0
    add_column :items, :likes_counter, :integer, default: 0
  end
end
