class AddColumnCountToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :columns_count, :integer, default: 1
  end
end
