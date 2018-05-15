class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :uid
      t.float :price
      t.float :in_stock
      t.text :discription
      t.string :group_uid
      t.integer :brand_id
      t.timestamps
    end
  end
end
