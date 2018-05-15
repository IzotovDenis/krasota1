class AddColumnsToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :disabled, :boolean, default: false
    add_column :groups, :display_name, :string
    add_column :groups, :sort, :integer
  end
end
