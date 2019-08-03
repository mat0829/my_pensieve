class Emotion < ActiveRecord::Base 
  has_many :memory_emotions
  has_many :memories, through: :memory_emotions
end