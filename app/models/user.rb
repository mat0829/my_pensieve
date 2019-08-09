class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_secure_password
  
  has_many :memories
  has_and_belongs_to_many :emotions, through: :memories
end