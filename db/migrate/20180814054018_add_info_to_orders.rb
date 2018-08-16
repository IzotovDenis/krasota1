class AddInfoToOrders < ActiveRecord::Migration[5.1]
    def change
      add_column :orders, :info, :jsonb
    end
  end