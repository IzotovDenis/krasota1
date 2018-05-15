class AddFormedToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :formed, :boolean, default: false
    add_column :orders, :formed_at, :datetime
  end
end
