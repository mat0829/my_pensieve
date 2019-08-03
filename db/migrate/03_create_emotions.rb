class CreateEmotions < ActiveRecord::Migration
  def change
    create_table :emotions do |t|
      t.string :feeling
      t.integer :memory_id
    end
  end
end
