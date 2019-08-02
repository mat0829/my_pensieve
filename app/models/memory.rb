class Memory < ActiveRecord::Base 
  belongs_to :user
  has_many :emotions
  has_many :players
end