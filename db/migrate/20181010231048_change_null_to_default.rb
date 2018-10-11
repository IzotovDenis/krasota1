class ChangeNullToDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :orders, :info, {}
    change_column_default :payments, :info, {}
  end
end
