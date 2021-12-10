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
    the_wallet.nickname = params.fetch("query_nickname")
    the_wallet.user_id = session.fetch(:user_id)
   
    address = params.fetch("query_address")
    url = "https://api.etherscan.io/api?module=account&action=balance&address=#{address}&tag=latest&apikey=6VHX7KNJWUI1XBXB8D562B4VCGJGMNZMDH"
    raw_response = open(url).read
    parsed_response = JSON.parse(raw_response)
    balance = (parsed_response.fetch("result").to_f / 10**18).round(4)

    the_wallet.balance = balance
    
    url2 = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"

    raw_response2 = open(url2).read
    parsed_response2 = JSON.parse(raw_response2)
    value = (parsed_response2.fetch("USD") * balance).round(2) 

    the_wallet.value = value
    @list_of_wallets = Wallet.all
    if the_wallet.valid?
      the_wallet.save
      redirect_to("/", { :notice => "Wallet track successfull." })
    else
      redirect_to("/", { :notice => "Wallet track failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_wallet = Wallet.where({ :id => the_id }).at(0)

    address = the_wallet.address
    
    url = "https://api.etherscan.io/api?module=account&action=balance&address=#{address}&tag=latest&apikey=6VHX7KNJWUI1XBXB8D562B4VCGJGMNZMDH"
    raw_response = open(url).read
    parsed_response = JSON.parse(raw_response)
    balance = (parsed_response.fetch("result").to_f / 10**18).round(4)

    the_wallet.balance = balance
    
    url2 = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"

    raw_response2 = open(url2).read
    parsed_response2 = JSON.parse(raw_response2)
    value = (parsed_response2.fetch("USD") * balance).round(2) 

    the_wallet.value = value
    the_wallet.save
    
  end

  def destroy
    
    the_id = params.fetch(:id)
    the_wallet = Wallet.where({ :id => the_id }).at(0)

    the_wallet.destroy

    redirect_to("/", { :notice => "Wallet deleted successfully."} )
  end

  def watchlist
    
    render({:template => "/wallets/index.html.erb"})
  end 
end
