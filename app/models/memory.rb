class Memory < ActiveRecord::Base
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
  
  def slug
      self.title.gsub(" ", "-").downcase
  end
  
  def self.find_by_slug(slug)
      self.all.find{ |instance| instance.slug == slug }
  end
end