class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, name: "index_orders_on_user_id", using: :btree
      t.integer :amount, default: 0
      t.integer :items_count, default: 0
      t.jsonb :items, default: {} 
      t.timestamps
    end
  end
end
