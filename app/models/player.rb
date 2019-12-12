class Player < ActiveRecord::Base
  has_many :memory_players
  has_many :memories, through: :memory_players
  has_many :users, through: :memories

  def name=(s)
    write_attribute(:name, s.to_s.titleize)
  end
  
  def slug
    self.name.gsub(" ", "-").downcase
  end
  
  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end
end