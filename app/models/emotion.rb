class Emotion < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  has_many :memory_emotions
  has_many :memories, through: :memory_emotions
  
end