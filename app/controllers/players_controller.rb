class PlayersController < ApplicationController
  
  get '/players' do
   if logged_in?
    @players = current_user.players.uniq
    erb :'/players/index'
    else
      redirect_to '/login'
    end
  end
  
  get '/players/:slug' do
    if logged_in?
      @player = Player.find_by_slug(params[:slug])
      @player.memories = @player.memories.where(user_id: current_user.id)
      erb :'players/show'
    else
      redirect_to '/login'
    end
  end
  
  get '/players/:slug/edit' do
    if logged_in?
      if params[:name] == ""
        redirect to "/players/#{params[:slug]}/edit"
      else
      @player = Player.find_by_slug(params[:slug])
      erb :'players/edit'
      end
    else
      redirect to '/login'
    end
  end
  
  patch '/players/:slug' do
    if logged_in?
      if params[:name] == ""
        redirect to "/players/#{params[:slug]}/edit"
      else
        @player = Player.find_by_slug(params[:slug])
        @player.update(name: params[:name])
        redirect to "/players/#{@player.slug}"
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/players/:slug/delete' do
    if logged_in?
      @player = Player.find_by_slug(params[:slug])
        @player.delete
      redirect to '/players'
    else
      redirect to '/login'
    end
  end
  
end