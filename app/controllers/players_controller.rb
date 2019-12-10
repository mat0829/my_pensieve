class PlayersController < ApplicationController
  
  get '/players' do
    redirect_if_not_logged_in
    @players = current_user.players.uniq.sort_by{ |obj| obj.name }
    erb :'/players/index'
  end
  
  get '/players/:slug' do
    redirect_if_not_logged_in
    @player = Player.find_by_slug(params[:slug])
    @player.memories = @player.memories.where(user_id: current_user.id)
    erb :'players/show'
  end
  
  get '/players/:slug/edit' do
    redirect_if_not_logged_in
    if params[:name] == ""
      redirect to "/players/#{params[:slug]}/edit"
    else
      @player = Player.find_by_slug(params[:slug])
      erb :'players/edit'
    end
  end
  
  patch '/players/:slug' do
    redirect_if_not_logged_in
    if params[:name] == ""
      redirect to "/players/#{params[:slug]}/edit"
    else
      @player = Player.find_by_slug(params[:slug])
      @player.update(name: params[:name])
      redirect to "/players/#{@player.slug}"
    end
  end
  
  delete '/players/:slug/delete' do
    redirect_if_not_logged_in
    @player = Player.find_by_slug(params[:slug])
    @player.delete
    redirect to '/players'
  end
  
end