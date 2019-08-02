class UsersController < ApplicationController
  
  get '/signup' do 
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please Sign up below or "}
    else
      redirect to '/memories'
    end
  end
  
end