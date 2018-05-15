class AddImageToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :image, :jsonb, default: {exist: false}
  end
end
