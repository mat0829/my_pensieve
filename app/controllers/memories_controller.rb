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
      erb :'memories/create_memory'
    else
      redirect to '/login'
    end
  end

  post '/memories' do
    if logged_in?
      if params[:content] == "" || params[:title] == ""
        redirect to "/memories/new"
      else
        @memory = current_user.memories.build(title: params[:title], content: params[:content])
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

  get '/memories/:id/edit' do
    if logged_in?
      @memory = Memory.find_by_id(params[:id])
      if @memory && @memory.user == current_user
        erb :'memories/edit_memory'
      else
        redirect to '/memories'
      end
    else
      redirect to '/login'
    end
  end

  patch '/memories/:id' do
    if logged_in?
      if params[:content] == "" || params[:title] == ""
        redirect to "/memories/#{params[:id]}/edit"
      else
        @memory = Memory.find_by_id(params[:id])
        if @memory && @memory.user == current_user
          if @memory.update(content: params[:content])
            redirect to "/memories/#{@memory.id}"
          else
            redirect to "/memories/#{@memory.id}/edit"
          end
        else
          redirect to '/memories'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/memories/:id/delete' do
    if logged_in?
      @memory = Memory.find_by_id(params[:id])
      if @memory && @memory.user == current_user
        @memory.delete
      end
      redirect to '/memories'
    else
      redirect to '/login'
    end
  end
end