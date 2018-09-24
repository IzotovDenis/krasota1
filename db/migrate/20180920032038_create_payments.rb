class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.integer :amount
      t.string :merchant_order_id
      t.integer :status
      t.jsonb :info

      t.timestamps
    end
  end
end
