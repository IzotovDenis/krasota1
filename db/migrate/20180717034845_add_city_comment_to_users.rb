class AddCityCommentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :city, :string
    add_column :users, :comment, :text
  end
end
