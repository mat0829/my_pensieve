class MemoriesController < ApplicationController
  
  get '/memories' do
    if logged_in?
      @memories = Memory.all
      erb :'memories/memories'
    else
      redirect to '/login'
    end
  end
  
  get '/memories/new' do
    if logged_in?
      erb :'memories/add_memory'
    else
      redirect to '/login'
    end
  end
  
end