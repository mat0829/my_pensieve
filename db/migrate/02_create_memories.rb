class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :name 
    end
  end
end
