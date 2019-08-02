class EmotionsController < ApplicationController
  
  get '/emotions' do
    if logged_in?
      @tweets = Tweet.all
      erb :'emotions/emotions'
    else
      redirect to '/login'
    end
  end
  
end