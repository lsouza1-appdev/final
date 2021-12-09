class WalletsController < ApplicationController
  def index
    matching_wallets = Wallet.all

    @list_of_wallets = matching_wallets.order({ :created_at => :desc })

    render({ :template => "wallets/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_wallets = Wallet.where({ :id => the_id })

    @the_wallet = matching_wallets.at(0)

    render({ :template => "wallets/show.html.erb" })
  end

  def create
    the_wallet = Wallet.new
    the_wallet.address = params.fetch("query_address")
    the_wallet.user_id = session.fetch(:user_id)
   
    address = params.fetch("query_address")
    url = "https://api.etherscan.io/api?module=account&action=balance&address=#{@address}&tag=latest&apikey=6VHX7KNJWUI1XBXB8D562B4VCGJGMNZMDH"
    raw_response = open(url).read
    parsed_response = JSON.parse(raw_response)
    balance = @parsed_response.fetch("result")

    the_wallet.balance = balance
    
    url2 = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"

    raw_response2 = open(url2).read
    parsed_response2 = JSON.parse(raw_response2)
    value = @parsed_response.fetch("result") * balance 

    the_wallet.balance = balance

    if the_wallet.valid?
      the_wallet.save
      redirect_to("/wallets", { :notice => "Wallet created successfully." })
    else
      redirect_to("/wallets", { :notice => "Wallet failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_wallet = Wallet.where({ :id => the_id }).at(0)

    the_wallet.address = params.fetch("query_address")
    the_wallet.user_id = params.fetch("query_user_id")
    the_wallet.balance = params.fetch("query_balance")

    if the_wallet.valid?
      the_wallet.save
      redirect_to("/wallets/#{the_wallet.id}", { :notice => "Wallet updated successfully."} )
    else
      redirect_to("/wallets/#{the_wallet.id}", { :alert => "Wallet failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_wallet = Wallet.where({ :id => the_id }).at(0)

    the_wallet.destroy

    redirect_to("/wallets", { :notice => "Wallet deleted successfully."} )
  end

  def watchlist
    
    render({:template => "/wallets/index.html.erb"})
  end 
end
