class EmotionsController < ApplicationController
  
  get '/emotions' do
    @emotions = Emotion.all
    erb :'emotions/index'
  end

  get '/emotions/:slug' do
    @emotion = Emotion.find_by_slug(params[:slug])
    erb :'emotions/show'
  end
  
end