class CreateMemoryPlayers < ActiveRecord::Migration
  def change
    create_table :memory_players do |t|
      t.integer :memory_id
      t.integer :player_id 
    end
  end
end
