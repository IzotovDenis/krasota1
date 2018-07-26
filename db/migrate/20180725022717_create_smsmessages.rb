class CreateSmsmessages < ActiveRecord::Migration[5.1]
  def change
    create_table :smsmessages do |t|
      t.integer :user_id
      t.string :pin
      t.string :tel
      t.boolean :sended, default: false
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
