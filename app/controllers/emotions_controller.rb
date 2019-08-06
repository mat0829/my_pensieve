class EmotionsController < ApplicationController
  get '/emotions' do
    @emotions = Emotion.all
    erb :'emotions/index'
  end

  get '/emotions/:id' do
    @genre = Emotion.find_by_slug(params[:slug])
    erb :'/emotions/show_memory'
  end
end