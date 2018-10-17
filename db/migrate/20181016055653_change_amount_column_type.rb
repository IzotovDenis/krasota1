class ChangeAmountColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :amount, :integer
  end
end
