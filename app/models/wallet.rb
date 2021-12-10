# == Schema Information
#
# Table name: wallets
#
#  id         :integer          not null, primary key
#  address    :string
#  balance    :float
#  nickname   :string
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Wallet < ApplicationRecord
end
