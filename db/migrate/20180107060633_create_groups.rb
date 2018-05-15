class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :title
      t.string :ancestry
      t.boolean :has_items
      t.integer :items_count
      t.string :parent_uid
      
      t.timestamps
    end
  end
end
