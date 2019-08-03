class CreateEmotions < ActiveRecord::Migration
  def change
    create_table :emotions do |t|
      t.string :feeling
    end
  end
end
