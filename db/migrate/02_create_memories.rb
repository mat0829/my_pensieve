class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :title
      t.string :content
      t.string :emotion
      t.string :player
      t.integer :user_id
    end
  end
end
