class Memory < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
end