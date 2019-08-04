class EmotionsController < ApplicationController 
  
  get '/emotions' do
    if logged_in?
      @emotions = Emotion.all
      erb :'emotions/index'
    else
      redirect to '/login'
    end
  end
  
  get '/emotions/:slug' do 
    @genre = Genre.find_by_slug(params[:slug])

    erb :'genres/show_emotion'
  end
  
end