class MemoriesController < ApplicationController
  
  get '/memories' do
    @memories = Memory.all
    erb :'memories/index'
  end
  
  get '/memories/new' do
    @memories = Memory.all
    @emotions = Emotion.all
    erb :'memories/new'
  end

  post '/memories' do
    if params[:name] == "" || params[:content] == ""
      redirect to 'memories/new'
    end
    @memory = current_user.memories.create(name: params[:name], content: params[:content])
    @memory.emotion_ids = params[:emotions]
    @memory.save

    redirect to "memories/#{@memory.slug}"
  end
  
  get '/memories/:slug' do
    @memory = Memory.find_by_slug(params[:slug])
    erb :'memories/show'
  end

  get '/memories/:slug/edit' do
    @memory = Memory.find_by_slug(params[:slug])
    @emotions = Emotion.all
    erb :'memories/edit'
  end

  patch '/memories/:slug' do
    @memory = Memory.find_by_slug(params[:slug])
    @memory.update(params["memory"])

    redirect to "memories/#{@memory.slug}"
  end
  
end