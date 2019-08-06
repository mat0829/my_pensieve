class PlayersController < ApplicationController
  get '/players' do
    @players = Player.all
    erb :'players/players'
  end

  get '/players/:id' do
    @player = Player.find_by_slug(params[:slug])
    erb :'/players/show_player'
  end
end