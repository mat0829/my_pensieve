class Memory < ActiveRecord::Base 
  belongs_to :user
  has_many :players
  has_many :emotions
end