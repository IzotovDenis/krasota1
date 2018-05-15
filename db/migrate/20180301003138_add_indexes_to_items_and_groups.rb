class AddIndexesToItemsAndGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :uid, :string
    add_index :items, :uid, unique: true
    add_index :groups, :uid, unique: true
  end
end