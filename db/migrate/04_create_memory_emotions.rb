class CreateMemoryEmotions < ActiveRecord::Migration
  def change
    create_table :memory_emotions do |t|
      t.integer :memory_id
      t.integer :emotion_id
    end
  end
end