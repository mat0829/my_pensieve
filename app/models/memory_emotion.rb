class MemoryEmotion < ActiveRecord::Base
  belongs_to :memory
  belongs_to :emotion
end