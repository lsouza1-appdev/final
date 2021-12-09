class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.string :address
      t.integer :user_id
      t.float :balance

      t.timestamps
    end
  end
end
