class AddNicknameToWallet < ActiveRecord::Migration[6.0]
  def change
    add_column :wallets, :nickname, :string
  end
end
