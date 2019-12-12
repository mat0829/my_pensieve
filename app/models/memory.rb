class Memory < ActiveRecord::Base
  belongs_to :user
  has_many :memory_emotions
  has_many :emotions, through: :memory_emotions
  has_many :memory_players
  has_many :players, through: :memory_players
  validates :title, :content, presence: true
  validates :title, uniqueness: true

  def title=(s)
    write_attribute(:title, s.to_s.titleize)
  end
  
  def slug
    self.title.gsub(" ", "-").downcase + self.id.to_s
  end
  
  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end
end