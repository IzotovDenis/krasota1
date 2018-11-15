class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.text :html
      t.string :link
      t.index :link, unique: true
      t.timestamps
    end
  end
end
