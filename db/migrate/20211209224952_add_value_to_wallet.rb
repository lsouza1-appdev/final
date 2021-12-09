class AddValueToWallet < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :value, :float
  end
end
