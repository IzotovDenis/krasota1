class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :image
      t.string :filename

      t.timestamps
    end
  end
end
