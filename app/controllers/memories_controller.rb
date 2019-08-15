class MemoriesController < ApplicationController
  
  get '/memories' do
    if logged_in?
      @memories = current_user.memories
      erb :'memories/index'
    else
      redirect to '/login'
    end
  end

  get '/memories/new' do
    if logged_in?
      @emotions = Emotion.all
      @players = []
      current_user.memories.map do |memory|
        memory.players.map do |player|
          @players << player.name unless @players.include?(player.name)
        end
      end
      erb :'memories/new'
    else
      redirect to '/login'
    end
  end

  post '/memories' do
    if logged_in?
      if params[:title] == "" || params[:content] == ""
        redirect to "/memories/new"
      else
        binding.pry
        @memory = current_user.memories.build(title: params[:title], content: params[:content])
        @memory.emotion_ids = params[:emotions]
        @memory.player_ids = params[:players]
        if !params["emotion"]["name"].empty?
          @memory.emotions << Emotion.find_or_create_by(name: params["emotion"]["name"].capitalize)
        end
        if !params["player"]["name"].empty?
          @memory.players << Player.find_or_create_by(name: params["player"]["name"].capitalize)
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
      @emotions = Emotion.all
      @players = Player.all
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
      if params[:title] == "" || params[:content] == ""
        redirect to "/memories/#{params[:slug]}/edit"
      else
        @memory = Memory.find_by_slug(params[:slug])
        if @memory && @memory.user == current_user
          if @memory.update(title: params[:title], content: params[:content])
            @memory.emotions = []
            @memory.players = []
            params[:memory][:emotions_ids].each do |emotion_id|
              @memory.emotions << Emotion.find(emotion_id)
            end
            params[:memory][:players_ids].each do |player_id|
              @memory.players << Player.find(player_id)
              @memory.save
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