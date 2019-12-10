class EmotionsController < ApplicationController
  
  get '/emotions' do
    redirect_if_not_logged_in
    @emotions = current_user.emotions.uniq.sort_by{ |obj| obj.name }
    erb :'/emotions/index'
  end
  
  get '/emotions/:slug' do
    redirect_if_not_logged_in
    @emotion = Emotion.find_by_slug(params[:slug])
    @emotion.memories = @emotion.memories.where(user_id: current_user.id)
    erb :'emotions/show'
  end
  
  get '/emotions/:slug/edit' do
    redirect_if_not_logged_in
    if params[:name] == ""
      redirect to "/emotions/#{params[:slug]}/edit"
    else
    @emotion = Emotion.find_by_slug(params[:slug])
    erb :'emotions/edit'
    end
  end
  
  patch '/emotions/:slug' do
    redirect_if_not_logged_in
    if params[:name] == ""
      redirect to "/emotions/#{params[:slug]}/edit"
    else
      @emotion = Emotion.find_by_slug(params[:slug])
      @emotion.update(name: params[:name])
      redirect to "/emotions/#{@emotion.slug}"
    end
  end
  
  delete '/emotions/:slug/delete' do
    redirect_if_not_logged_in
    @emotion = Emotion.find_by_slug(params[:slug])
      @emotion.delete
    redirect to '/emotions'
  end
end