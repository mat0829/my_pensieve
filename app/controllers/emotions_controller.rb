class EmotionsController < ApplicationController 
  
  get '/emotions' do
    if logged_in?
      @emotions = Emotion.all
      erb :'emotions/emotions'
    else
      redirect to '/login'
    end
  end
  
  get '/emotions/new' do
    if logged_in?
      erb :'emotions/create_emotion'
    else
      redirect to '/login'
    end
  end
  
  post '/emotions' do
    if logged_in?
      if params[:feeling] == ""
        redirect to "/emotions/new"
      else
        @emotion = Emotion.create(feeling: params[:feeling])
        if @emotion.save
          redirect to "/emotions/#{@emotion.id}"
        else
          redirect to "/emotions/new"
        end
      end
    else
      redirect to '/login'
    end
  end
  
  get '/emotions/:id' do
    if logged_in?
      @emotion = Emotion.find_by_id(params[:id])
      erb :'emotions/show_emotion'
    else
      redirect to '/login'
    end
  end
  
end