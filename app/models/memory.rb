class Memory < ActiveRecord::Base 
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
  has_many :memory_players
  has_many :players, through: :memory_players
  
  def slug
      self.name.gsub(" ", "-").downcase
  end
  
  def self.find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
  end
end