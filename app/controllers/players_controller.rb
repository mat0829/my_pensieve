class PlayersController < ApplicationController
  
  get '/players' do
   if logged_in?
    @players = Player.all
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
  
end