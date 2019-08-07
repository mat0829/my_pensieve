class Player < ActiveRecord::Base 
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  has_many :memory_players
  has_many :memories, through: :memory_players
  
end