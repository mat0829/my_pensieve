class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :content
      t.string :emotions
      t.integer :user_id
    end
  end
end
