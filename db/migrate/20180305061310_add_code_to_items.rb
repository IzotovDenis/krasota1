class AddCodeToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :code, :string
  end
end
