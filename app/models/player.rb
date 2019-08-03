class Player < ActiveRecord::Base 
  has_many :memory_players
  has_many :memories, through: :memory_players
end