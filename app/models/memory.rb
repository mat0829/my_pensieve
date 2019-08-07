class Memory < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
  has_many :memory_players
  has_many :players, through: :memory_players
  
end