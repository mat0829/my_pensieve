class Emotion < ActiveRecord::Base 
  belongs_to :user
  belongs_to :memory
end