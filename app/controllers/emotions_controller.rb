class EmotionsController < ApplicationController
  
  get '/emotions' do
   if logged_in?
    @emotions = current_user.emotions.uniq
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
  
  get '/emotions/:slug/edit' do
    if logged_in?
      if params[:name] == ""
        redirect to "/emotions/#{params[:slug]}/edit"
      else
      @emotion = Emotion.find_by_slug(params[:slug])
      erb :'emotions/edit'
      end
    else
      redirect to '/login'
    end
  end
  
  patch '/emotions/:slug' do
    if logged_in?
      if params[:name] == ""
        redirect to "/emotions/#{params[:slug]}/edit"
      else
        @emotion = Emotion.find_by_slug(params[:slug])
        @emotion.update(name: params[:name])
        redirect to "/emotions/#{@emotion.slug}"
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/emotions/:slug/delete' do
    if logged_in?
      @emotion = Emotion.find_by_slug(params[:slug])
        @emotion.delete
      redirect to '/emotions'
    else
      redirect to '/login'
    end
  end
end