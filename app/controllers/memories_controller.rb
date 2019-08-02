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
  
  post '/memories' do
    if logged_in?
      if params[:content] == ""
        redirect to "/memories/new"
      else
        @memory = current_user.memories.build(content: params[:content])
        if @memory.save
          redirect to "/memories/#{@memory.id}"
        else
          redirect to "/memories/new"
        end
      end
    else
      redirect to '/login'
    end
  end
  
  get '/memories/:id' do
    if logged_in?
      @memory = Memory.find_by_id(params[:id])
      erb :'memories/show_memory'
    else
      redirect to '/login'
    end
  end
  
end