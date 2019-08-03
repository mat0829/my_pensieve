class Memory < ActiveRecord::Base 
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
  has_many :memory_players
  has_many :players, through: :memory_players
end