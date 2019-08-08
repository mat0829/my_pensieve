class EmotionsController < ApplicationController
  get '/memories/:id/emotions/new' do
    if logged_in?
      @memory = Memory.find(params[:id])
      erb :'emotions/new'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  post '/memories/:id' do
    if params.values.any? {|value| value == ""}
      @memory = Memory.find(params[:id])
      erb :'emotions/new', locals: {message: "You are missing information!"}
    else
      @memory = Memory.find(params[:id])
      @emotion = Emotion.new(name: params[:name])
      @emotion.save
      @memory.emotions << @emotion
      redirect to "/memories/#{@memory.id}"
    end
  end

  delete '/memories/:id/emotions/:emotion_id/delete' do 
    @memory = Memory.find(params[:id])
    @emotion = Emotion.find(params[:emotion_id])
    if logged_in?
      @memory = Memory.find(params[:id])
      if @memory.user_id == session[:user_id]
        @emotion = Emotion.find(params[:emotion_id])
        @emotion.delete
        redirect to "/memories/#{@memory.id}"
      else
        redirect to "/memories/#{@memory.id}"
      end
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

end