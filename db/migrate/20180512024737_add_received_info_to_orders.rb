class AddReceivedInfoToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :received, :boolean, default: false
    add_column :orders, :received_at, :datetime
  end
end
