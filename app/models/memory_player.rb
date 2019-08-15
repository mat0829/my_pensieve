class MemoryPlayer < ActiveRecord::Base
  belongs_to :memory
  belongs_to :player
end