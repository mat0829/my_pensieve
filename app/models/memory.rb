class Memory < ActiveRecord::Base
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
end