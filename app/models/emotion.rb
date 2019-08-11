class Emotion < ActiveRecord::Base
  has_many :memory_emotions
  has_many :memories, through: :memory_emotions
  
  def slug
      self.name.gsub(" ", "-").downcase
  end
  
  def self.find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
  end
end