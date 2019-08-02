class UsersController < ApplicationController
  
  get '/signup' do 
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please Sign up below or "}
    else
      redirect to '/memories'
    end
  end
  
  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/memories'
    end
  end
  
  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/memories'
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/memories"
    else
      redirect to '/signup'
    end
  end
  
end