class AddOrderUrlToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :order_url, :string
  end
end
