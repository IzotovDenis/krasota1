class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.string :title
      t.string :uid
      t.integer :items_count
      t.timestamps
    end
  end
end
