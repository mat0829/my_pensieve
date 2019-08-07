class MemoriesController < ApplicationController
  
  get '/memories' do
    if logged_in?
      @memories = Memory.all
      erb :'memories/index'
    else
      redirect to '/login'
    end
  end

  get '/memories/new' do
    if logged_in?
      erb :'memories/new'
    else
      redirect to '/login'
    end
  end

  post '/memories' do
    if logged_in?
      if params[:name] == "" || params[:content] == ""
        redirect to "/memories/new"
      else
        @memory = current_user.memories.create(name: params[:name], content: params[:content])
        unless params[:emotion][:name].empty?
        @memory.emotions << Emotion.create(params[:emotion])
        end
        if @memory.save
          redirect to "/memories/#{@memory.slug}"
        else
          redirect to "/memories/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/memories/:slug' do
    if logged_in?
      @memory = Memory.find_by_slug(params[:slug])
      erb :'memories/show'
    else
      redirect to '/login'
    end
  end

  get '/memories/:slug/edit' do
    if logged_in?
      @memory = Memory.find_by_slug(params[:slug])
      if @memory && @memory.user == current_user
        erb :'memories/edit'
      else
        redirect to '/memories'
      end
    else
      redirect to '/login'
    end
  end

  patch '/memories/:slug' do
    if logged_in?
      if params[:name] == "" || params[:content] == ""
        redirect to "/memories/#{params[:slug]}/edit"
      else
        @memory = Memory.find_by_slug(params[:slug])
        if @memory && @memory.user == current_user
          if @memory.update(name: params[:name], content: params[:content])
          unless params[:emotion][:name].empty?
            @memory.emotions << Emotion.create(params[:emotion])
          end 
            redirect to "/memories/#{@memory.slug}"
          else
            redirect to "/memories/#{@memory.slug}/edit"
          end
        else
          redirect to '/memories'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/memories/:slug/delete' do
    if logged_in?
      @memory = Memory.find_by_slug(params[:slug])
      if @memory && @memory.user == current_user
        @memory.delete
      end
      redirect to '/memories'
    else
      redirect to '/login'
    end
  end
end