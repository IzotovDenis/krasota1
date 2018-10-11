class AddPayableToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payable, :boolean, default: true
  end
end
