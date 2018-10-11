class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :thirdname, :string
    add_column :users, :zip_code, :string
    add_column :users, :address, :text
  end
end
