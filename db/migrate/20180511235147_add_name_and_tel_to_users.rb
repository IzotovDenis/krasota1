class AddNameAndTelToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :tel, :string
    add_column :users, :created_from_1c, :boolean, default: false
    add_index :users, :tel, unique: true
    add_index :users, :email, unique: true
  end
end
