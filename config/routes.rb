Rails.application.routes.draw do
  # Routes for the Wallet resource:

  # CREATE
  post("/insert_wallet", { :controller => "wallets", :action => "create" })
          
  # READ
  get("/wallets", { :controller => "wallets", :action => "index" })
  
  get("/wallets/:path_id", { :controller => "wallets", :action => "show" })
  
  # UPDATE
  
  #post("/modify_wallet/:path_id", { :controller => "wallets", :action => "update" })
  
  # DELETE
  get("/delete_wallet/:path_id", { :controller => "wallets", :action => "destroy" })

  # UPDATE
  
  
  #
  patch("/update/:path_id", { :controller => "wallets", :action => "update"})
  
  # DELETE
  delete("/delete_wallet/:id", { :controller => "wallets", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  get("/", {:controller => "application", :action => "home"})
  
  get("/refresh_prices", {:controller => "application", :action => "update_prices"})


  get("/wallet/:address", {:controller => "application", :action => "get_wallet"})

  
end
