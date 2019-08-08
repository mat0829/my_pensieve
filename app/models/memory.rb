class Memory < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  belongs_to :user
  has_many :emotions
end