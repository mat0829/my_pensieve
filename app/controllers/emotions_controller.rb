class EmotionsController < ApplicationController
  
  get '/emotions' do
   if logged_in?
    @emotions = Emotion.all
    erb :'/emotions/index'
    else
      redirect_to '/login'
    end
  end
  
  get '/emotions/:slug' do
    if logged_in?
      @emotion = Emotion.find_by_slug(params[:slug])
      @emotion.memories = @emotion.memories.where(user_id: current_user.id)
      erb :'emotions/show'
    else
      redirect_to '/login'
    end
  end
  
end