class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def home

    render({:template => "templates/home.html.erb"})
  end  
  

  def get_wallet
    
    @address = params.fetch("address")
    
    url = "https://api.etherscan.io/api?module=account&action=balance&address=#{@address}&tag=latest&apikey=6VHX7KNJWUI1XBXB8D562B4VCGJGMNZMDH"
    url2 = "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"
    @raw_response = open(url).read
    @parsed_response = JSON.parse(@raw_response)
    @balance = @parsed_response.fetch("result")
    render({:template => "templates/wallet.html.erb"})
     
  end

  def update_prices
    user_id = session.fetch(:user_id)
    selected_wallets = Wallet.where({:user_id => user_id}).all
    selected_wallets.each do |the_wallet|
      
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

    redirect_to('/')
  end

  




end
