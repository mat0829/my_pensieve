class MemoriesController < ApplicationController
  
  get '/memories' do
    redirect_if_not_logged_in
    @memories = current_user.memories.sort_by{ |obj| obj.title }
    erb :'memories/index'
  end

  get '/memories/new' do
    redirect_if_not_logged_in
    @emotions = current_user.emotions.uniq
    @players = current_user.players.uniq
    erb :'memories/new'
  end

  post '/memories' do
    redirect_if_not_logged_in
    if params[:title] == "" || params[:content] == ""
      redirect to "/memories/new"
    else
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
  end

  get '/memories/:slug' do
    redirect_if_not_logged_in
    @memory = current_user.memories.find_by_slug(params[:slug])
    erb :'memories/show'
  end

  get '/memories/:slug/edit' do
    redirect_if_not_logged_in
    @memory = Memory.find_by_slug(params[:slug])
    @emotions = current_user.emotions.uniq
    @players = current_user.players.uniq
    if @memory && @memory.user == current_user
      erb :'memories/edit'
    else
      redirect to '/memories'
    end
  end

  patch '/memories/:slug' do
    redirect_if_not_logged_in
    if params[:title] == "" || params[:content] == ""
      redirect to "/memories/#{params[:slug]}/edit"
    else
      @memory = Memory.find_by_slug(params[:slug])
      if @memory && @memory.user == current_user
        if @memory.update(title: params[:title], content: params[:content])
          @memory.emotions = []
          @memory.players = []
          if !params["emotion"]["name"].empty?
            @memory.emotions << Emotion.find_or_create_by(name: params["emotion"]["name"].capitalize)
          end
          if !params["player"]["name"].empty?
            @memory.players << Player.find_or_create_by(name: params["player"]["name"].capitalize)
          end
          if params[:memory] !=  nil
            if params[:memory][:emotions_ids] != nil
              params[:memory][:emotions_ids].each do |emotion_id|
                @memory.emotions << Emotion.find(emotion_id)
                @memory.save
              end
            end
            if params[:memory][:players_ids] != nil
              params[:memory][:players_ids].each do |player_id|
                @memory.players << Player.find(player_id)
                @memory.save
              end
            end
          end
          redirect to "/memories/#{@memory.slug}"
        else
          redirect to "/memories/#{@memory.slug}/edit"
        end
      else
        redirect to '/memories'
      end
    end
  end

  delete '/memories/:slug/delete' do
    redirect_if_not_logged_in
    @memory = Memory.find_by_slug(params[:slug])
    if @memory && @memory.user == current_user
      @memory.delete
    end
    redirect to '/memories'
  end
end