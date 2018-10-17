class ChangePriceColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :price, :integer
  end
end
