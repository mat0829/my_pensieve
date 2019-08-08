class MemoriesController < ApplicationController
  
  get '/memories' do
    if logged_in?
      @memories = Memory.all
      erb :'memories/index'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"} 
    end
  end

  get '/memories/new' do
    if logged_in?
      erb :'memories/new'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  post '/memories' do
    if params.values.any? {|value| value == ""}
      erb :'memories/new', locals: {message: "You're missing information!"}
    else
      user = User.find(session[:user_id])
      @memory = Memory.create(name: params[:name], content: params[:content], user_id: user.id)
      redirect to "/memories/#{@memory.id}"
    end
  end

  get '/memories/:id' do 
    if logged_in?
      @memory = Memory.find(params[:id])
      erb :'memories/show'
    else 
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  get '/memories/:id/edit' do
    if logged_in?
      @memory = Memory.find(params[:id])
      if @memory.user_id == session[:user_id]
       erb :'memories/edit'
      else
      erb :'memories', locals: {message: "You don't have access to edit this project"}
      end
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  patch '/memories/:id' do 
    if params.values.any? {|value| value == ""}
      @memory = Memory.find(params[:id])
      erb :'memories/edit', locals: {message: "You're missing information"}
      redirect to "/memories/#{params[:id]}/edit"
    else
      @memory = Memory.find(params[:id])
      @memory.name = params[:name]
      @memory.content = params[:content]
      @memory.save
      redirect to "/memories/#{@memory.id}"
    end
  end

  delete '/memories/:id/delete' do 
    @memory = Memory.find(params[:id])
    if session[:user_id]
      @memory = Memory.find(params[:id])
      if @memory.user_id == session[:user_id]
        @memory.delete
        redirect to '/memories'
      else
        redirect to '/memories'
      end
    else
      redirect to '/login'
    end
  end
  
end